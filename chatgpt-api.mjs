import { OpenAIClient, AzureKeyCredential } from "@azure/openai";

// You will need to set these environment variables or edit the following values
const endpoint = `https://${process.env.RESOURCE_NAME}.openai.azure.com/`;
const azureApiKey = process.env.AZURE_API_KEY;
const deploymentId = process.env.DEPLOY_NAME;

console.log(`Using deployment ${deploymentId}, endpoint: ${endpoint}`);

let prompt = `Compare the number of grains of sand on Earth and the product of pow(62,10).`;
//获取用户在控制台传入的参数，赋值给 prompt
if (process.argv.length > 2) {
  prompt = process.argv[2];
}

console.log(`prompt: ${prompt}`);

const messages = [
  { role: "system", content: "You are a helpful assistant. Your name is Albert Einstein." },
  { role: "user", content: prompt },
];

async function main() {
  console.log("== Streaming Chat Completions Sample ==");

  const client = new OpenAIClient(endpoint, new AzureKeyCredential(azureApiKey));
  const events = client.listChatCompletions(deploymentId, messages, { maxTokens: 2048 });

  for await (const event of events) {
    for (const choice of event.choices) {
      process.stdout.write(`${choice.delta?.content || ""}`);
    }
  }
}

main().catch((err) => {
  console.error("The sample encountered an error:", err);
});