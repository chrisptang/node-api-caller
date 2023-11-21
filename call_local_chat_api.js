import fetch from "node-fetch"

const data = {
    "max_tokens": 2048,
    "messages": [{
        "content": "You are a helpful code assistant who very willing to provide full functional codes according to user request. Your are also very willing to provide answers to user's question even if they are not about coding", "role": "system"
    }, {
        "content": "Write a function with javascript to find all integer pairs that has sum equals to given target in any given integer array. please avoid O(n^2) time complexity algorithms.",
        "role": "user"
    }]
}

