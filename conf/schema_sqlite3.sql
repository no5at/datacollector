CREATE TABLE ticker_data (
  id INTEGER PRIMARY KEY,
  created_at TEXT,
  trade_pair TEXT,
  ask_price REAL,
  ask_volume REAL,
  bid_price REAL,
  bid_volume REAL,
  last_trade_price REAL,
  last_trade_volume REAL
);

CREATE TABLE trigger (
  id INTEGER PRIMARY KEY,
  created_at TEXT,
  trade_pair TEXT,
  low REAL,
  high REAL
);

CREATE TABLE defcon (
  id INTEGER PRIMARY KEY,
  updated_at TEXT,
  trade_pair TEXT,
  level INTEGER
);
