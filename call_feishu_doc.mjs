import fetch from "node-fetch"

const USER_TOKEN = "u-f_RNMAo8tdM96HJRGHpTtZ5g2gQ0glF9qa0000280dcb";
const WIKI_DOC_TOKEN = "KrhXw8AHAiqANVkAVJtcFDYencd";
const AZURE_API_ENDPOINT = process.env.AZURE_API_ENDPOINT;
const AZURE_API_KEY = process.env.AZURE_API_KEY;

async function getNode() {
    const response = await fetch(`https://open.feishu.cn/open-apis/wiki/v2/spaces/get_node?token=${WIKI_DOC_TOKEN}`, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${USER_TOKEN}`
        }
    });
    const data = await response.json();
    return data.data.node.obj_token;
}

async function getRawContent(docInWiki) {
    // blocks: `https://open.feishu.cn/open-apis/docx/v1/documents/${docInWiki}/blocks`
    // raw_content: `https://open.feishu.cn/open-apis/docx/v1/documents/${docInWiki}/raw_content`
    const response = await fetch(`https://open.feishu.cn/open-apis/docx/v1/documents/${docInWiki}/blocks`, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${USER_TOKEN}`
        }
    });
    const data = await response.json();
    return data;
}

async function postMessageToAzureAPI(userMessage, endpoint = AZURE_API_ENDPOINT, apiKey = AZURE_API_KEY) {
    const body = {
        stream: false,
        messages: [
            {
                role: "system",
                content: "现在你是一个测试工程师，请根据用户提供的需求文档内容，为他编写一个测试计划，计划应该包括核心功能和主流程"
            },
            {
                role: "user",
                content: userMessage
            }
        ]
    };

    const response = await fetch(endpoint, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'api-key': apiKey
        },
        body: JSON.stringify(body)
    });

    return await response.json();;
}

async function main() {
    try {
        const docInWiki = await getNode();
        const docRawContent = await getRawContent(docInWiki);

        // console.log("docRawContent:\n", JSON.stringify(docRawContent));

        const markdownContent = convertJsonToMarkdown(docRawContent)
        console.log("\n\n\nmarkdown content:\n", markdownContent);

        // console.log(JSON.stringify(await postMessageToAzureAPI(docRawContent)));
    } catch (error) {
        console.error(error);
    }
}

// Function to convert a JSON block to Markdown
function jsonToMarkdown(block, document) {

    let markdown = '';

    if (block.heading1) {
        markdown += `# ${block.heading1.elements[0].text_run.content}\n`;
    }

    if (block.heading2) {
        markdown += `## ${block.heading2.elements[0].text_run.content}\n`;
    }

    if (block.heading3) {
        markdown += `### ${block.heading3.elements[0].text_run.content}\n`;
    }

    if (block.heading4) {
        markdown += `#### ${block.heading4.elements[0].text_run.content}\n`;
    }

    if (block.heading5) {
        markdown += `##### ${block.heading5.elements[0].text_run.content}\n`;
    }

    if (block.heading6) {
        markdown += `###### ${block.heading6.elements[0].text_run.content}\n`;
    }

    if (block.block_type == 12 && block.bullet && block.bullet.elements) {
        markdown += `${block.bullet.elements.map(bullet => { return bullet.text_run.content }).join("\n")}\n`;
    }

    if (block.text) {
        markdown += block.text.elements[0].text_run.content + '\n';
    }

    if (block.table) {

        const header = Object.keys(block.table.property.column_width)
            .map(key => block.table.property.column_width[key])
            .join('|')

        markdown += `|${header}|\n`;
        markdown += `|:-:|:-:|:-:|:-:|:-:|\n`;

        markdown += "|" + block.table.cells.map(cell => {
            // console.log("table cell:", JSON.stringify(cell))
            // console.log("Object.keys:", Object.keys(document));
            let cell_content = jsonToMarkdown(document.data.items.find(b => b.block_id === cell));
            console.log("cell_content:", cell_content)
            if (cell_content.endsWith("\n")) {
                cell_content = cell_content.slice(0, -1);
            }
            return cell_content;
        }).join("|") + "|";

    }

    if (markdown.length <= 1) {
        console.warn("unknow block:", JSON.stringify(block));
    }

    return markdown;

}

// Main function
function convertJsonToMarkdown(json) {

    let markdown = '';

    json.data.items.forEach(block => {
        markdown += jsonToMarkdown(block, json);
    });

    return markdown;
}

main();