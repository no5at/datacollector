CREATE TABLE ticker_data (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE,
  trade_pair TEXT,
  ask_price FLOAT8,
  ask_volume FLOAT8,
  bid_price FLOAT8,
  bid_volume FLOAT8,
  last_trade_price FLOAT8,
  last_trade_volume FLOAT8
);
