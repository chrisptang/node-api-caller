import fetch from 'node-fetch';
import fs from 'fs';
import { Matrix } from 'ml-matrix';

import csv from 'csv-parser';
import { promisify } from 'util';

const args = process.argv.slice(2); // Remove first two elements

// Printing the arguments
console.log(args);

const readFile = promisify(fs.readFile);

async function readCSV(csvFilePath = 'all_cosfodb_ddl_embeddings.csv') {
  try {
    const jsonArray = [];
    const fileStream = fs.createReadStream(csvFilePath).pipe(csv());

    for await (const row of fileStream) {
      jsonArray.push(row);
    }
    return jsonArray;
  } catch (error) {
    console.error('Error reading CSV:', error);
    return null;
  }
}

async function getEmbeddingForInput(input = '') {
  const apiUrl = `http://${process.env.my_ip}:8000/v1/embeddings`;
  // Make the API request using node-fetch
  const response = await fetch(apiUrl, {
    method: 'POST',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ input }),
  });

  if (response.ok) {
    const responseData = await response.json();
    let embedding = responseData.data[0].embedding;
    console.log(`input:${input}, embedding:${embedding}`);
    return embedding;
  } else {
    console.error('API Request Error:', response.statusText);
    return null;
  }
}

const RESOURCE_NAME = process.env.RESOURCE_NAME;
const AZURE_API_KEY = process.env.AZURE_API_KEY;
const DEPLOY_NAME_EMBEDDING = process.env.DEPLOY_NAME_EMBEDDING;
const url = `https://${RESOURCE_NAME}.openai.azure.com/openai/deployments/${DEPLOY_NAME_EMBEDDING}/embeddings?api-version=2023-05-15`;

async function getEmbeddingsFromAzure(inputText = '') {
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
      let embedding = data.data[0].embedding;
      console.log(`inputText:${inputText}\nusage:${JSON.stringify(data.usage)}\nembedding:${embedding}`); // Handle the response data here
      return embedding;
    } else {
      console.log('Request failed:', response.status, response.statusText);
    }
  } catch (error) {
    console.log('An error occurred:', error);
  }
}


function dotProduct(vector1, vector2) {
  let product = 0;
  for (let i = 0; i < vector1.length; i++) {
      product += vector1[i] * vector2[i];
  }
  return product;
}

function magnitude(vector) {
  return Math.sqrt(vector.reduce((sum, value) => sum + value ** 2, 0));
}

function cosineSimilarity(vector1, vector2) {
  if (vector1.length !== vector2.length) {
      throw new Error("Vectors must have the same length");
  }

  const dot = dotProduct(vector1, vector2);
  const mag1 = magnitude(vector1);
  const mag2 = magnitude(vector2);

  if (mag1 === 0 || mag2 === 0) {
      throw new Error("Magnitude of a vector cannot be zero");
  }

  return dot / (mag1 * mag2);
}

async function stringsRankedByRelatedness(embedding_of_query = [], ddl_embeddings = [], topN = 5) {
  // console.log("ddl_embeddings[10]", JSON.stringify(ddl_embeddings[10]));
  let strings_and_relatednesses = ddl_embeddings.map(singleEmbedding => {
    if (!singleEmbedding.embedding) {
      console.error("invalid embedding:", singleEmbedding.embedding);
      return { ...singleEmbedding, score: 0 };
    }
    return { ...singleEmbedding, score: cosineSimilarity(embedding_of_query, JSON.parse(`[${singleEmbedding.embedding}]`)) }
  });
  let tow_matched_rows = strings_and_relatednesses.sort((a, b) => b.score - a.score).slice(0, topN);

  let matched_text = tow_matched_rows.map(row => {
    let row_without_embedding = { ...row };
    if (row_without_embedding.embedding) {
      delete row_without_embedding.embedding;
    }
    return row_without_embedding;
  });
  // console.log("top matched:", JSON.stringify(matched_text));
  return matched_text;
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

async function runSimpleQueryEmbedding(csvFile, searchQuery, use_azure = false) {
  let allEmbeddings = await readCSV(csvFile);
  let embeddingOfQuery = use_azure ? await getEmbeddingsFromAzure(searchQuery) : await getEmbeddingForInput(searchQuery);
  let matched = await stringsRankedByRelatedness(embeddingOfQuery, allEmbeddings, 10);
  console.log(`\nsearchQuery:${searchQuery},\nmatched:${matched.map(json => JSON.stringify(json)).join("\n")}\n`);
}

runSimpleQueryEmbedding(args[0], args[1], args[2] == 'use_azure')
