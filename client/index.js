// const express = require('express');
// const app = express();
// const port = 3000;

// app.get('/', (req, res) => {
//   res.send('Hello, World!');
// });

// app.listen(port, () => {
//   console.log(`Server is running at http://localhost:${port}`);
// });

const { rewrite } = require('./ollama');

const results = rewrite("The quick brown fox jumps over the lazy dog.").then((results) => {
  console.log(results);
}).catch((error) => {
  console.error("Error:", error);
});
