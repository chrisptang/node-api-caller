import fs from 'fs';
import mammoth from 'mammoth';
import PDFJS from 'pdfjs-dist';
import fsExtra from 'fs-extra';

const inputFilePath = '/Users/tangpeng/Desktop/帆台标准版产品操作手册.pdf';
const outputFilePath = '/Users/tangpeng/Desktop/帆台标准版产品操作手册.pdf.md';

async function extractTextFromPDF(pdfPath) {
    const data = new Uint8Array(fs.readFileSync(pdfPath));
    const loadingTask = PDFJS.getDocument({ data });

    const pdfDocument = await loadingTask.promise;
    const numPages = pdfDocument.numPages;
    let text = '';

    for (let pageNum = 1; pageNum <= numPages; pageNum++) {
        const page = await pdfDocument.getPage(pageNum);
        const content = await page.getTextContent();
        console.log(content)
        content.items.forEach(item => {
            text += item.str;
        });
        text += "\n\n";
    }

    return text;
}

async function convertPDFToMarkdown(pdfPath, markdownPath) {
    try {
        const text = await extractTextFromPDF(pdfPath);
        fs.writeFileSync(markdownPath, text, 'utf-8');
        console.log(`Conversion completed. Markdown saved to ${markdownPath}`);
    } catch (error) {
        console.error('Error converting PDF to Markdown:', error);
    }
}

async function run() {
    var options = {
        convertImage: mammoth.images.imgElement(function (image) {
            return "ignored_image";
            // return image.read("base64").then(function(imageBuffer) {
            //     return {
            //         src: "data:" + image.contentType + ";base64," + imageBuffer
            //     };
            // });
        })
    };
    let markdown = await mammoth.convertToHtml({ path: inputFilePath }, options);
    fs.writeFile(outputFilePath, markdown.value, (err) => {
        if (err) {
            console.error('Error writing the output file:', err);
            return;
        }
        console.log('Conversion completed successfully!');
    });
}

// run()

convertPDFToMarkdown(inputFilePath, outputFilePath)