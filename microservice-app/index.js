// index.js

const express = require('express');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Basic logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.originalUrl}`);
  next();
});

// Simple home route
app.get('/', (req, res) => {
  res.send('Hello, secure microservice!');
});

// Health-check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// Environment variables demo endpoint (optional secure demo)
app.get('/config', (req, res) => {
  res.json({ secretConfig: process.env.SECRET_CONFIG || "No config set" });
});

// Start listening
app.listen(port, () => {
  console.log(`Microservice running securely on port ${port}`);
});
