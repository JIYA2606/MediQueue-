const express = require('express');
const path = require('path');
const app = express();
const port = Number(process.env.PORT || 3000);
app.use(express.json());
app.use(express.static(__dirname));

// Optional MySQL connection check. The demo works without database credentials;
// this endpoint reports whether a configured MySQL connection can be reached.
app.get('/api/health', async (_req, res) => {
  if (!process.env.DB_HOST) return res.json({ mode: 'demo', database: 'not configured' });
  let connection;
  try {
    const mysql = require('mysql2/promise');
    connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      port: Number(process.env.DB_PORT || 3306),
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      connectTimeout: 3000
    });
    await connection.ping();
    res.json({ mode: 'mysql-ready', database: 'connected' });
  } catch (error) {
    res.status(503).json({ mode: 'mysql-ready', database: 'unavailable', message: error.message });
  } finally {
    if (connection) await connection.end();
  }
});
app.get('*', (_req, res) => res.sendFile(path.join(__dirname, 'index.html')));
app.listen(port, () => console.log(`MediQueue demo running at http://localhost:${port}`));
