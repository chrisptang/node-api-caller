import fs from 'fs';
import csv from 'csv-parser';
import fetch from 'node-fetch';
import { createObjectCsvWriter } from 'csv-writer';

// usage:
// node create_embedding_for_csv.mjs some_csv_file.csv some_column,another_column,yet_column

console.log(process.argv)

const csvFilePath = process.argv[2]
const columns = process.argv[3].split(",")
const embedding_file_suffix = process.argv[4] || "";

const apiUrl = `http://${process.env.my_ip}:8000/v1/embeddings`;

const CONCURRENTY_LEVEL = 4;

async function processCSV() {
  try {
    const fileStream = fs.createReadStream(csvFilePath);

    let resultWithEmbedding = [];

    let rowIndex = 0;
    for await (const row of fileStream.pipe(csv())) {
      resultWithEmbedding[resultWithEmbedding.length] = row;
      resultWithEmbedding.row_index = rowIndex++;
    }

    let arrayOfRows = splitArray(resultWithEmbedding, CONCURRENTY_LEVEL);
    let threads = [];
    for (let i = 0; i < arrayOfRows.length; i++) {
      threads[threads.length] = getEmbeddingOfArray(arrayOfRows[i], columns, i);
    }

    await Promise.all(threads);

    const csvWriter = createObjectCsvWriter({
      path: `embedding_of_${csvFilePath}${embedding_file_suffix.length > 0 ? "_" + embedding_file_suffix : ""}.csv`,
      header: Object.keys(resultWithEmbedding[0]).map(key => { return { id: key, title: key } })
    });
    await csvWriter.writeRecords(resultWithEmbedding);
    console.log('CSV file has been written successfully.');
  } catch (error) {
    console.error('Error:', error.message);
  }
}

async function getEmbeddingOfArray(rows = [], columns = [], thread_id = 0) {
  let resultWithEmbedding = [];

  let running = 0;
  for await (const row of rows) {
    // Concatenate the desired columns with a space
    const input = columns.map(col => row[col]).join(", ");
    console.log(`thread_id:${thread_id}, input:${input}, running:${running++}`);
    // row.embedding = await getEmbeddingForInput(input);
    row.embedding = await getEmbeddingsFromAzure(input);
  }
  return resultWithEmbedding;
}

async function getEmbeddingForInput(input = '') {
  // console.log(`creating embedding for:${input}`)
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
    console.log(`input:${input}, responseData:${responseData}`);
    return responseData.data[0].embedding;
  } else {
    console.error('API Request Error:', response.statusText);
    return null;
  }
}

function splitArray(arr = [], numOfSubArr = 1) {
  if (arr.length <= numOfSubArr) {
    return arr;
  }
  let result = [];
  let size = arr.length / numOfSubArr;
  for (let i = 0; i < arr.length; i += size) {
    result.push(arr.slice(i, i + size));
  }
  return result;
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
      console.log(JSON.stringify(data.usage)); // Handle the response data here
      return data.data[0].embedding;
    } else {
      console.log('Request failed:', response.status, response.statusText);
    }
  } catch (error) {
    console.log('An error occurred:', error);
  }
}

processCSV();
