const OLLAMA_API_URL = "http://192.168.1.37:8080/o/api/generate";

async function Rewrite(sentence) {
    const message = `Rewrite the following sentence in a more concise and clear manner: "${sentence}"`;

    const response = await fetch(OLLAMA_API_URL, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            model: "llama3.2:1b",
            prompt: message,
            stream: false,
            options: {
                num_predict: 200
            }
        })
    });

    const data = await response.json();
    return data.choices[0].text;
}