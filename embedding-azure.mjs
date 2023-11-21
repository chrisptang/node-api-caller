import fetch from 'node-fetch';
import fs from 'fs';
import { createObjectCsvWriter } from 'csv-writer';
import { Matrix } from 'ml-matrix';

import csv from 'csv-parser';
import { promisify } from 'util';

const args = process.argv.slice(2); // Remove first two elements

// Printing the arguments
console.log(args);

const IS_XIANMU = args && args[0] && 'xianmu' === args[0];
const CREATE_EMBEDDING = args && args[1] && 'embedding' === args[1];

const readFile = promisify(fs.readFile);

async function readCSV(csvFilePath = 'all_cosfodb_ddl_embeddings.csv') {
  try {
    const jsonArray = [];
    const fileStream = fs.createReadStream(csvFilePath).pipe(csv());

    for await (const row of fileStream) {
      jsonArray.push({
        Text: row.Text,
        Embeddings: row.Embeddings,
      });
    }

    return jsonArray;
  } catch (error) {
    console.error('Error reading CSV:', error);
    return null;
  }
};

async function writeToCSV(embeddingData, database_name = 'cosfodb') {
  try {
    let path = `all_${database_name}_ddl_embeddings.csv`;
    const csvWriter = createObjectCsvWriter({
      path,
      header: [
        { id: 'text', title: 'Text' },
        { id: 'embeddings', title: 'Embeddings' }
      ]
    });
    await csvWriter.writeRecords(embeddingData);
    console.log('CSV file written successfully:', path);
    return path;
  } catch (error) {
    console.error(error);
  }
};

const RESOURCE_NAME = process.env.RESOURCE_NAME;
const AZURE_API_KEY = process.env.AZURE_API_KEY;
const DEPLOY_NAME_EMBEDDING = process.env.DEPLOY_NAME_EMBEDDING;
const url = `https://${RESOURCE_NAME}.openai.azure.com/openai/deployments/${DEPLOY_NAME_EMBEDDING}/embeddings?api-version=2023-05-15`;

async function getEmbeddings(inputText = '') {
  const headers = {
    'Content-Type': 'application/json',
    'api-key': AZURE_API_KEY
  };
  const body = {
    input: inputText
  };

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers,
      body: JSON.stringify(body)
    });

    if (response.ok) {
      const data = await response.json();
      console.log(JSON.stringify(data.usage)); // Handle the response data here
      return data.data[0].embedding;
    } else {
      console.log('Request failed:', response.status, response.statusText);
    }
  } catch (error) {
    console.log('An error occurred:', error);
  }
}

async function getEmbeddingsForDdl(database_name = 'cosfodb') {
  let ddl_list = getAllDdl(`all_${database_name}_ddl.sql`);
  let embeddingData = [];
  for (let text of ddl_list) {
    let new_embedding = { text, embeddings: await getEmbeddings(text) }
    embeddingData[embeddingData.length] = new_embedding;
    console.log("new_embedding:\n", JSON.stringify(new_embedding));
  };

  await writeToCSV(embeddingData, database_name);
}

function getAllDdl(ddlFileName = "all_cosfodb_ddl.sql") {
  const content = fs.readFileSync(ddlFileName, 'utf8');

  // Split the content into small chunks by '---'
  const chunks = content.split('---');

  console.log(JSON.stringify(chunks[1]));
  return chunks;
}

function cosineSimilarity(x, y) {
  // console.log("X:", JSON.stringify(x))
  const vectorX = new Matrix([x]);

  let vectorY;
  try {
    vectorY = new Matrix([JSON.parse(`[${y}]`)]);
  } catch (err) {
    console.error("Y:", y, err);
  }


  // Calculate the dot product of x and y
  const dotProduct = vectorX.dot(vectorY);

  // Calculate the magnitudes of x and y
  const magnitudeX = vectorX.norm();
  const magnitudeY = vectorY.norm();

  // Calculate the cosine similarity
  const similarity = dotProduct / (magnitudeX * magnitudeY);

  return similarity;
}

async function stringsRankedByRelatedness(query, ddl_embeddings = [], topN = 5) {
  let embedding_of_query = await getEmbeddings(query);
  console.log("ddl_embeddings[10]", JSON.stringify(ddl_embeddings[10]));
  let strings_and_relatednesses = ddl_embeddings.map(singleEmbedding => {
    if (!singleEmbedding.Embeddings) {
      console.error("invalid embedding:", singleEmbedding.Embeddings);
      return { text: singleEmbedding.Text, score: 0 };
    }
    return { text: singleEmbedding.Text, score: cosineSimilarity(embedding_of_query, singleEmbedding.Embeddings) }
  });
  let top_ddl = strings_and_relatednesses.sort((a, b) => b.score - a.score).slice(0, topN);

  let ddlText = top_ddl.map(ddl => ddl.text).join(";\n");
  console.log("top_ddl:", ddlText);
  return ddlText;
}

const DEPLOY_NAME_GPT35 = process.env.DEPLOY_NAME;
const BASE_URL = `https://${RESOURCE_NAME}.openai.azure.com/openai/deployments/${DEPLOY_NAME_GPT35}/chat/completions`;
const API_VERSION = '2023-05-15';

const headers = {
  'Content-Type': 'application/json',
  'api-key': AZURE_API_KEY
};

async function makeOpenIAIRequest(sqlQuery, ddlText) {
  try {
    const data = {
      temperature: 1.0,
      stream: false,
      messages: [
        { role: 'system', content: `现在的时间是:${new Date()}, 你是一个优秀的数据库工程师，特别擅长根据用户的输入来编写SQL查询数据，请你保持回答的简洁性，对SQL的解析不要超过50字。请你完全基于以下DDL语句来回答用户的请求。如果你没有找到用户请求的表，请你不要猜测，请不要使用不存在的表，这种情况下请你向用户提问，或者回答"抱歉我没找到答案"。以下是全部可用的DDL语句:\n"""\n${ddlText}\n"""` },
        { role: 'user', content: sqlQuery }
      ]
    };
    const response = await fetch(`${BASE_URL}?api-version=${API_VERSION}`, {
      method: 'POST',
      headers,
      body: JSON.stringify(data)
    });

    if (!response.ok) {
      throw new Error(`Request failed with status code ${response.status}`);
    }

    const result = await response.json();
    console.log(`User query:${sqlQuery},\n\nResult from GPT:\n${result.choices[0].message.content}`);
  } catch (error) {
    console.error('Error:', error.message);
  }
}

async function runSimpleQueryEmbedding() {
  if (CREATE_EMBEDDING) {
    await getEmbeddingsForDdl(IS_XIANMU ? "xianmudb" : "cosfodb");
  }

  let result = await readCSV();
  console.log(`embedding length:${result.length}`);
  // let query = "请找出租户ID=32、创建时间晚于10月10号的订单中，分账成功的的所有订单数据，取100条最新的数据。再根据订单ID找出来所有的订单详细数据(order表)。请将订单状态字段根据该字段的注释用case...when...语句转成可阅读文本，比如‘已完成’等";
  let query = "请找出sku='abc12134575'在'杭州市、西湖区'这个区域所使用的库存仓和城配仓，以及该sku的在线库存是多少。"+
  "如果SQL中出现了`状态`类字段，请根据该字段的注释用`case...when...`语句转成可阅读文本，比如‘已发货’等";
  let ddlText = await stringsRankedByRelatedness(query, result, 8);
  await makeOpenIAIRequest(query, ddlText);
}

runSimpleQueryEmbedding()