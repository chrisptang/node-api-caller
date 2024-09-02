/**curl https://generativelanguage.googleapis.com/v1/models/gemini-pro:streamGenerateContent?key=$GOOGLE_AI_API_KEY \
    -H 'Content-Type: application/json' \
    -X POST \
    -d '{ "contents":[
      { "parts":[{"text": "请帮忙计算这个商品的单位价格：555263082180,红颜草莓（盆装） 3斤*1盒/二级/单果7-10g, $32.0"}]}
    ]
}' */
import fetch from 'node-fetch';
import { HttpsProxyAgent } from "https-proxy-agent";
import fs from 'fs'
import os from 'os'
import moment from 'moment'
import path from 'path'

const TIME_OF_NOW = new Date().toISOString().split("T")[0]

const homeDir = os.homedir();
const dirToCreate = path.join(homeDir, 'gemini');

fs.mkdirSync(dirToCreate, { recursive: true }, (error) => {
  if (error) {
    console.error('An error occurred while creating the directory', error);
  } else {
    console.log('Directory created successfully');
  }
});

const fileName = `${dirToCreate}/conversion_${TIME_OF_NOW}.md`;

if (!fs.existsSync(fileName)) {
  fs.writeFileSync(fileName, '');
}

const agent = new HttpsProxyAgent(process.env.HTTP_PROXY || "http://0.0.0.0:8001");
const GOOGLE_AI_API_KEY = process.env.GOOGLE_AI_API_KEY;
const MD_LINE_BREAK = '\n\n'
const HUMAN_COLOR = '<p style="border-radius: 5px;padding:2px;background-color: lightskyblue;color:#fff;font-size:larger;font-weight:bolder;">', HUMAN_COLOR_END = '</p>'

let prompt = `Compare the number of grains of sand on Earth and the product of pow(62,10).`;
//获取用户在控制台传入的参数，赋值给 prompt
if (process.argv.length > 2) {
  prompt = process.argv[2];
}
let request_body = {
  "contents": [
    {
      "role": "USER",
      "parts": { "text": prompt }
    }
  ],
  "safety_settings": {
    "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
    "threshold": "BLOCK_LOW_AND_ABOVE"
  },
  "generation_config": {
    "temperature": 0.3,
    "maxOutputTokens": 2048,
  }
}

const now = moment().format('YYYY-MM-DD HH:mm:ss');

async function make_gemini_call(data) {
  const headers = {
    "Content-Type": "application/json",

  };
  const postJson = { headers };
  postJson.agent = agent;
  let gemini_version = "gemini-1.0-pro"
  gemini_version = "gemini-1.5-pro"
  gemini_version = "gemini-1.5-flash"
  let url = `https://generativelanguage.googleapis.com/v1/models/${gemini_version}:streamGenerateContent?key=${GOOGLE_AI_API_KEY}`
  console.log("making request to:", url);
  if (data) {
    //POST as json
    postJson.method = "POST";
    postJson.body = JSON.stringify(data);
  }
  let chunkOfBody = '';
  try {
    let response = await fetch(url, postJson);
    let completions = ""
    process.stdout.write(`requested text:${data.contents[0].parts.text}\n`);
    for await (let chunk of response.body) {
      chunk = chunk.toString();
      chunkOfBody += chunk;
      let candidates_list = tryParseJsonArray(chunkOfBody)
      if (!candidates_list) {
        // 说明不是全部
        continue;
      } else {
        chunkOfBody = '';
      }

      for (let candidates of candidates_list) {
        process.stdout.write(candidates.candidates[0].content.parts[0].text);
        completions = `${completions}${candidates.candidates[0].content.parts[0].text}`
      }
    }
    process.stdout.write("\n");
    fs.appendFileSync(fileName, `${MD_LINE_BREAK}###${now} ${MD_LINE_BREAK}${HUMAN_COLOR}User: ${prompt}${HUMAN_COLOR_END} ${MD_LINE_BREAK}GEMINI:${MD_LINE_BREAK}${completions}${MD_LINE_BREAK}`)
    console.log(`response was wroten into file:${fileName}`)
  } catch (err) {
    console.error(`request error:${err.message}, chunkOfBody:${chunkOfBody}`, err);
  }
}

function tryParseJsonArray(str) {
  try {
    return JSON.parse(str);
  } catch (err) {
    // console.log(`not a json array:${str}`)
    return null;
  }
}

make_gemini_call(request_body)