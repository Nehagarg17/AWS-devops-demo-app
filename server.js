const express = require('express');
const os = require('os');
const app = express();
const port = process.env.PORT || 4000;

app.get('/', (req, res) => {
  res.send({
    message: "Hello from AWS DevOps Dummy App",
    host: os.hostname(),
    timestamp: new Date().toISOString()
  });
});

app.get('/echo/:text', (req, res) => {
  res.send({ echo: req.params.text });
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});
