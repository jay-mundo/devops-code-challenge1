// index.js
const express = require('express');
const cors = require('cors');
const { v4: uuidv4 } = require('uuid'); // to generate GUID

const app = express();

// Allow requests from frontend at localhost:3000
app.use(cors({ origin: 'http://localhost:3000' }));

// Optional: parse JSON requests
app.use(express.json());

// Success endpoint
app.get('/success', (req, res) => {
  const guid = uuidv4();
  res.json({ message: `SUCCESS + ${guid}` });
});

// Start server
const PORT = 8080;
app.listen(PORT, () => {
  console.log(`Backend started on port ${PORT}`);
});

