import Anthropic from '@anthropic-ai/sdk';
import { HttpsProxyAgent } from "https-proxy-agent";
import fs from 'fs'
import moment from 'moment'
import os from 'os'
import path from 'path'
import readline from 'readline'

const MODEL = process.env.CLAUDE_MODEL || 'claude-3-opus-20240229'

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

const TIME_OF_NOW = new Date().toISOString().split("T")[0]

const homeDir = os.homedir();
const dirToCreate = path.join(homeDir, 'claude');
const now = moment().format('YYYY-MM-DD HH:mm:ss');

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

const HTTP_PROXY = process.env.HTTP_PROXY || 'http://0.0.0.0:8001';

const proxyAgent = new HttpsProxyAgent(HTTP_PROXY);

console.log(`using HTTP_PROXY:${HTTP_PROXY}`)

// Configure the default for all requests:
const anthropic = new Anthropic({
  httpAgent: proxyAgent,
  apiKey: `${process.env.ANTHROPIC_API_KEY}`
});


const SESSION_CACHE = [];

function append_new_message(msg, is_assistant = false) {
  SESSION_CACHE.push(
    {
      "role": is_assistant ? "assistant" : "user",
      "content": [
        {
          "type": "text",
          "text": msg
        }
      ]
    });
  return SESSION_CACHE;
}

//获取用户在控制台传入的参数，赋值给 prompt
if (process.argv.length > 2) {
  let prompt = process.argv[2];
  call(prompt)
}

const MD_LINE_BREAK = '\n\n'
const HUMAN_COLOR = '<p style="border-radius: 5px;padding:2px;background-color: lightskyblue;color:#fff;font-size:larger;font-weight:bolder;">', HUMAN_COLOR_END = '</p>'
// Override per-request:
async function call(prompt) {
  const stream = await anthropic.messages.create(
    {
      max_tokens: 4096,
      temperature: 0,
      model: MODEL,
      stream: true,
      messages: append_new_message(prompt),
    }
  );
  let completions = "";
  for await (const completion of stream) {
    if ('message_start' == `${completion.type}`) {
      process.stdout.write(`message_start: ${JSON.stringify(completion)}\n\n`);
      continue;
    }
    if ('content_block_delta' == `${completion.type}`) {
      const new_text = `${completion.delta.text}`
      completions = `${completions}${new_text}`;
      process.stdout.write(`${new_text}`);
    }
  }
  process.stdout.write("\n")
  append_new_message(completions, true)
  fs.appendFileSync(fileName, `${MD_LINE_BREAK}###${now} ${MD_LINE_BREAK}${HUMAN_COLOR}${Anthropic.HUMAN_PROMPT} ${prompt}${HUMAN_COLOR_END} ${Anthropic.AI_PROMPT} ${completions}${MD_LINE_BREAK}`)
  console.log(`response was wroten into file:${fileName}`)
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
      await call(lines.join("\n"))
      lines = [];
    }
  }
});

rl.on('close', () => {
  console.log('Exiting program');
  process.exit(0);
});