const OLLAMA_API_URL = "http://192.168.1.37:8000/o/api/generate";

async function rewrite(sentence) {
  const message =
    "Rewrite the given sentence in a casual, natural tone. " +
    "Provide exactly 3 variants in JSON array format and " +
    "output only the rewritten sentences, with no explanations, labels, " +
    `or additional text: "${sentence}"`;

  const response = await fetch(OLLAMA_API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model: "llama3.2:1b",
      prompt: message,
      stream: false,
      options: {
        num_predict: 1000,
        temperature: 0.2,
        top_p: 0.6,
        top_k: 20,
      },
    }),
  });
  console.log("Response:", response);
  const data = await response.json();
  return data.response;
}

exports.rewrite = rewrite;
