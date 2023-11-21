import fetch from "node-fetch"
import HttpsProxyAgent from "https-proxy-agent";

const data = {
    "model": "gpt-3.5-turbo-0613",
    "stream": true,
    "messages": [{ "role": "user", "content": "who won NBA MVP in year 2019?" }]
}

