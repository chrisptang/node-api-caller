import Anthropic from '@anthropic-ai/sdk';
import { HttpsProxyAgent } from "https-proxy-agent";
import fs from 'fs'
import os from 'os'
import path from 'path'

const TIME_OF_NOW = new Date().toISOString().split("T")[0]

const homeDir = os.homedir();
const dirToCreate = path.join(homeDir, 'claude');

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


let prompt = `Compare the number of grains of sand on Earth and the product of pow(62,10).`;
//获取用户在控制台传入的参数，赋值给 prompt
if (process.argv.length > 2) {
  prompt = process.argv[2];
}

console.log(`prompt: ${prompt}`);

const MD_LINE_BREAK='\n\n'
const HUMAN_COLOR='<p style="border-radius: 5px;padding:2px;background-color: lightskyblue;color:#fff;font-size:larger;font-weight:bolder;">', HUMAN_COLOR_END='</p>'

// Override per-request:
async function call() {
  const stream = await anthropic.completions.create(
    {
      prompt: `${Anthropic.HUMAN_PROMPT} ${prompt} ${Anthropic.AI_PROMPT}`,
      max_tokens_to_sample: 4096,
      model: 'claude-2.1',
      stream: true,
    }
  );
  let completions = "";
  for await (const completion of stream) {
    completions = `${completions}${completion.completion}`;
    process.stdout.write(`${completion.completion}`);
  }
  process.stdout.write("\n")
  fs.appendFileSync(fileName, `${MD_LINE_BREAK}###${new Date().toISOString()} ${MD_LINE_BREAK}${HUMAN_COLOR}${Anthropic.HUMAN_PROMPT} ${prompt}${HUMAN_COLOR_END} ${Anthropic.AI_PROMPT} ${completions}`)
  console.log(`response was wroten into file:${fileName}`)
}

call()