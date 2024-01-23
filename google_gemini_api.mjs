/**curl https://generativelanguage.googleapis.com/v1/models/gemini-pro:streamGenerateContent?key=$GOOGLE_AI_API_KEY \
    -H 'Content-Type: application/json' \
    -X POST \
    -d '{ "contents":[
      { "parts":[{"text": "请帮忙计算这个商品的单位价格：555263082180,红颜草莓（盆装） 3斤*1盒/二级/单果7-10g, $32.0"}]}
    ]
}' */
import fetch from 'node-fetch';
import { HttpsProxyAgent } from "https-proxy-agent";

const agent = new HttpsProxyAgent(process.env.HTTP_PROXY || "unknow-proxy");
const GOOGLE_AI_API_KEY = process.env.GOOGLE_AI_API_KEY;

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
        "temperature": 0.2,
        "topP": 0.8,
        "topK": 40,
        "maxOutputTokens": 2048,
    }
}

async function make_gemini_call(data) {
    const headers = {
        "Content-Type": "application/json",

    };
    const postJson = { headers };
    postJson.agent = agent;
    let url = `https://generativelanguage.googleapis.com/v1/models/gemini-pro:streamGenerateContent?key=${GOOGLE_AI_API_KEY}`
    // console.log("making request to:", url);
    if (data) {
        //POST as json
        postJson.method = "POST";
        postJson.body = JSON.stringify(data);
    }
    let chunkOfBody = '';
    try {
        let response = await fetch(url, postJson);
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
                // console.log(JSON.stringify(candidates))
                process.stdout.write(candidates.candidates[0].content.parts[0].text);
            }
        }
        process.stdout.write("\n");
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

/**
 * [{
  "candidates": [
    {
      "content": {
        "parts": [
          {
            "text": "The number of grains of sand on Earth is estimated to be around 7."
          }
        ],
        "role": "model"
      },
      "finishReason": "STOP",
      "index": 0,
      "safetyRatings": [
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "probability": "NEGLIGIBLE"
        }
      ]
    }
  ],
  "promptFeedback": {
    "safetyRatings": [
      {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "probability": "NEGLIGIBLE"
      },
      {
        "category": "HARM_CATEGORY_HATE_SPEECH",
        "probability": "NEGLIGIBLE"
      },
      {
        "category": "HARM_CATEGORY_HARASSMENT",
        "probability": "NEGLIGIBLE"
      },
      {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "probability": "NEGLIGIBLE"
      }
    ]
  }
}
,
{
  "candidates": [
    {
      "content": {
        "parts": [
          {
            "text": "5 x 10^18, while the product of pow(62,10) is approximately 8.39 x 10"
          }
        ],
        "role": "model"
      },
      "finishReason": "STOP",
      "index": 0,
      "safetyRatings": [
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "probability": "NEGLIGIBLE"
        }
      ]
    }
  ]
}
,
{
  "candidates": [
    {
      "content": {
        "parts": [
          {
            "text": "^23.\n\nTherefore, the product of pow(62,10) is significantly larger than the number of grains of sand on Earth.\n\nIn fact, the product of pow(62,10) is roughly 10^5 times larger than the number of grains of sand on Earth"
          }
        ],
        "role": "model"
      },
      "finishReason": "STOP",
      "index": 0,
      "safetyRatings": [
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "probability": "NEGLIGIBLE"
        }
      ]
    }
  ]
}
,
{
  "candidates": [
    {
      "content": {
        "parts": [
          {
            "text": ". This means that if you were to count every grain of sand on Earth, one by one, it would take you approximately 10^5 times longer to count the product of pow(62,10)."
          }
        ],
        "role": "model"
      },
      "finishReason": "STOP",
      "index": 0,
      "safetyRatings": [
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "probability": "NEGLIGIBLE"
        }
      ]
    }
  ]
}
]%
*/