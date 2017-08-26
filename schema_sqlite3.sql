CREATE TABLE ticker_data (
  id INTEGER PRIMARY KEY,
  created_at TEXT,
  ask_price REAL,
  ask_volume REAL,
  bid_price REAL,
  bid_volume REAL,
  last_trade_price REAL,
  last_trade_volume REAL
);
