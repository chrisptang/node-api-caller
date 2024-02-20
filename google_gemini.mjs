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
import readline from 'readline'

process.stdout.setDefaultEncoding('utf8');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

process.stdout.write("Enter prompt to request content from Gemini. Press CLT+C to exit.\n")

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

const request_body = {
  "contents": [],
  "safety_settings": [{
    "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
    "threshold": "BLOCK_NONE"
  }, {
    "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
    "threshold": "BLOCK_NONE"
  }, {
    "category": "HARM_CATEGORY_HATE_SPEECH",
    "threshold": "BLOCK_NONE"
  }, {
    "category": "HARM_CATEGORY_HARASSMENT",
    "threshold": "BLOCK_NONE"
  }],
  "generation_config": {
    "temperature": 0.7,
    "maxOutputTokens": 2048,
  }
}

let prompt = "";
//获取用户在控制台传入的参数，赋值给 prompt
if (process.argv.length > 2) {
  prompt = process.argv[2];
  let request_body = buildRequestJsonForPrompt(prompt)
  make_gemini_call_nonchunk(request_body)
}

function buildRequestJsonForPrompt(prompt) {
  let part = {
    "role": "user",
    "parts": [{ "text": prompt }]
  };
  request_body.contents.push(part)
  return request_body;
}

function appendNewResponseToObject(responseText) {
  let part = {
    "role": "model",
    "parts": [{ "text": responseText }]
  };
  request_body.contents.push(part)
  return request_body;
}

async function make_gemini_call(data) {
  const now = moment().format('YYYY-MM-DD HH:mm:ss');
  const headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json;charset=UTF-8"
  };
  const postJson = { headers };
  postJson.agent = agent;
  // streamGenerateContent
  let url = `https://generativelanguage.googleapis.com/v1/models/gemini-1.0-pro:streamGenerateContent?key=${GOOGLE_AI_API_KEY}`
  if (data) {
    postJson.method = "POST";
    postJson.body = JSON.stringify(data);
  }
  let chunkOfBody = '';
  try {
    process.stdout.write(`requested prompt:${data.contents[data.contents.length - 1].parts[0].text}\n`);
    let response = await fetch(url, postJson);
    let completions = ""
    let chunk_times = []
    for await (let chunk of response.body) {
      chunk = chunk.toString('utf8');
      chunk_times.push(new Date())
      // process.stdout.write(`chunk:${chunk}`);
      chunkOfBody += chunk;
      let candidates_list = tryParseJsonArray(chunkOfBody)
      if (!candidates_list) {
        // 说明不是全部
        continue;
      } else {
        chunkOfBody = '';
      }

      for (let candidates of candidates_list) {
        if (!candidates?.candidates?.[0]?.content?.parts) {
          process.stderr.write(JSON.stringify(candidates));
          continue;
        }

        const text = candidates.candidates[0].content.parts[0]?.text;
        if (text) {
          process.stdout.write(text);
          completions += text;
        }
      }
    }
    process.stdout.write("\n");
    process.stdout.write(JSON.stringify(chunk_times));
    appendNewResponseToObject(completions)
    fs.appendFileSync(fileName, `${MD_LINE_BREAK}###${now} ${MD_LINE_BREAK}${HUMAN_COLOR}User: ${prompt}${HUMAN_COLOR_END} ${MD_LINE_BREAK}GEMINI:${MD_LINE_BREAK}${completions}${MD_LINE_BREAK}`)
    console.log(`response was wroten into file:${fileName}`)
  } catch (err) {
    console.error(`request error:${err.message}, chunkOfBody:${chunkOfBody}`, err);
  }
}

async function make_gemini_call_nonchunk(data) {
  const now = moment().format('YYYY-MM-DD HH:mm:ss');
  const headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json;charset=UTF-8"
  };
  const postJson = { headers };
  postJson.agent = agent;
  let url = `https://generativelanguage.googleapis.com/v1/models/gemini-1.0-pro:generateContent?key=${GOOGLE_AI_API_KEY}`
  if (data) {
    postJson.method = "POST";
    postJson.body = JSON.stringify(data);
  }
  try {
    process.stdout.write(`requested prompt:${data.contents[data.contents.length - 1].parts[0].text}\n`);
    let response = await fetch(url, postJson);
    response = await response.json();
    let completions = ""
    if (!response?.candidates?.[0]?.content?.parts) {
      process.stderr.write(JSON.stringify(response));
      return;
    }
    for (let part of response.candidates[0].content.parts) {
      const text = part.text;
      process.stdout.write(text);
      completions += text;
    }
    process.stdout.write("\n");
    appendNewResponseToObject(completions)
    fs.appendFileSync(fileName, `${MD_LINE_BREAK}###${now} ${MD_LINE_BREAK}${HUMAN_COLOR}User: ${prompt}${HUMAN_COLOR_END} ${MD_LINE_BREAK}GEMINI:${MD_LINE_BREAK}${completions}${MD_LINE_BREAK}`)
    console.log(`response was wroten into file:${fileName}`)
  } catch (err) {
    console.error(`request error:${err.message}`, err);
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

let lines = [];
rl.on('line', async (input) => {
  if (input === '\u0003') {
    rl.close();
  } else {
    if (input.endsWith('\\')) {
      lines.push(input.slice(0, -1));
      return;
    }
    lines.push(input);
    if (lines.length > 0) {
      let post_json = buildRequestJsonForPrompt(lines.join("\n"));
      await make_gemini_call_nonchunk(post_json)
      lines = [];
    }
  }
});

rl.on('close', () => {
  console.log('Exiting program');
  process.exit(0);
});