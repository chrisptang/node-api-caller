import fs from 'fs';
import csv from 'csv-parser';
import { promisify } from 'util';

const readFile = promisify(fs.readFile);
const csvFilePath = 'all_cosfodb_ddl_embeddings.csv';

const readCSV = async () => {
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

readCSV().then(result => {
  if (result) {
    console.log(result);
  }
});
