import { HttpsProxyAgent } from "https-proxy-agent";
import fs from 'fs'
import moment from 'moment'
import fetch from 'node-fetch';
import os from 'os'
import path from 'path'
import readline from 'readline'

const MODEL = process.env.GROQ_MODEL || 'llama3-70b-8192'
const MD_LINE_BREAK = '\n\n'
const HUMAN_COLOR = '\n> ', HUMAN_COLOR_END = '\n\n'

const TIME_OF_NOW = new Date().toISOString().split("T")[0]

const homeDir = os.homedir();
const dirToCreate = path.join(homeDir, 'groq-llama3');
const now = moment().format('YYYY-MM-DD HH:mm:ss');
const today = moment().format('YYYYMMDD');

const HTTP_PROXY = process.env.HTTP_PROXY || 'http://127.0.0.1:8001';
const proxyAgent = new HttpsProxyAgent(HTTP_PROXY);
console.log(`using HTTP_PROXY:${HTTP_PROXY}`)

import { Groq } from 'groq-sdk';

const groq = new Groq({ httpAgent: proxyAgent, });

async function getGroqChatCompletion(messages = []) {
  return groq.chat.completions.create({
    messages: messages,
    model: MODEL,
    temperature: 0.9,
    max_tokens: 8000,
    top_p: 1,
    stop: null,
    stream: true
  });
}

function generateRandomString(size = 32) {
  const characters = 'abcdef0123456789';
  let randomString = '';
  size = Math.max(10, size - today.length)

  // Generate random characters
  for (let i = 0; i < size; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    randomString += characters.charAt(randomIndex);
  }

  // Combine datetime and random string
  const result = `${today}${randomString}`;
  return result;
}

const NEW_NOTE_ID = generateRandomString();
console.log(`NEW_NOTE_ID:${NEW_NOTE_ID}`)

const JOPLIN_NOTE_SERVER = 'http://127.0.0.1:41184';
const JOPLIN_TOKEN = process.env.JOPLIN_TOKEN || '';

let NEED_CREATE_NOTE = true

async function createNewNoteWithIdAndBody(body, title) {
  title = `${today}: ${title}`
  title = title.substring(0, Math.min(60, title.length))

  const url = NEED_CREATE_NOTE ? `${JOPLIN_NOTE_SERVER}/notes` : `${JOPLIN_NOTE_SERVER}/notes/${NEW_NOTE_ID}`
  let data = {
    body, parent_id: '4f9f4819a9b645f0a84c02a5dd5c32c9' // LLaMa3@Groq
  };

  if (NEED_CREATE_NOTE) {
    data.id = NEW_NOTE_ID;
    data.title = title;
  }

  const response = await fetch(`${url}?token=${JOPLIN_TOKEN}`, {
    method: NEED_CREATE_NOTE ? 'POST' : 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  });

  const dataResponse = await response.json();
  if (dataResponse.error) {
    console.log(JSON.stringify(dataResponse))
  } else {
    NEED_CREATE_NOTE = false
  }
  return dataResponse;
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

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

const SESSION_CACHE = [];

// https://console.groq.com/docs/text-chat
function append_new_message(msg, is_assistant = false) {
  SESSION_CACHE.push(
    {
      "role": is_assistant ? "assistant" : "user",
      "content": msg
    });
  // console.log(JSON.stringify(SESSION_CACHE))
  return SESSION_CACHE;
}

//获取用户在控制台传入的参数，赋值给 prompt
if (process.argv.length > 2) {
  let prompt = process.argv[2];
  call(prompt)
}

let session_content_full = ""

// Override per-request:
async function call(prompt) {
  if (!prompt || prompt.length <= 2) {
    return;
  }
  const stream = await getGroqChatCompletion(append_new_message(prompt));
  let completions = "";
  process.stdout.write(`${MD_LINE_BREAK}LLaMa3:\n`);
  for await (const chunk of stream) {
    // Print the completion returned by the LLM.
    const new_text = chunk.choices[0]?.delta?.content || "";
    completions = `${completions}${new_text}`;
    process.stdout.write(`${new_text}`);
  }

  process.stdout.write(`${MD_LINE_BREAK}>>>`)
  append_new_message(completions, true)
  session_content_full = `${session_content_full}${MD_LINE_BREAK}### ${now} ${MD_LINE_BREAK}${HUMAN_COLOR}${prompt}${HUMAN_COLOR_END} \n**LLaMa3**: ${completions}${MD_LINE_BREAK}`
  fs.appendFileSync(fileName, session_content_full)
  try {
    await createNewNoteWithIdAndBody(session_content_full, prompt)
  } catch (e) {
    // ignore
    console.warn(e)
  }

}

let lines = [];
rl.on('line', async (input) => {
  console.log(input)
  if (input === '\u0003') {
    rl.close();
  } else {
    if (input.endsWith('\\')) {
      lines.push(input.slice(0, -1));
      return;
    }
    lines.push(input);
    const line_content = lines.join("\n");
    if (line_content.length > 2) {
      await call(line_content)
      lines = [];
    }
  }
});

rl.on('close', () => {
  console.log('Exiting program');
  process.exit(0);
});