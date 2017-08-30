INSERT INTO ticker_data (
  created_at,
  trade_pair,
  ask_price,
  ask_volume,
  bid_price,
  bid_volume,
  last_trade_price,
  last_trade_volume)
VALUES (
  '2017-08-30 22:00:00 UTC',
  'XBTEUR',
  3799.0, 1.0,
  3799.0, 1.0,
  3799.0, 1.0);

INSERT INTO ticker_data (
  created_at,
  trade_pair,
  ask_price,
  ask_volume,
  bid_price,
  bid_volume,
  last_trade_price,
  last_trade_volume)
VALUES (
  '2017-08-30 22:05:00 UTC',
  'XBTEUR',
  3801.0, 1.0,
  3801.0, 1.0,
  3801.0, 1.0);

INSERT INTO triggers (
  created_at,
  trade_pair,
  trigger_type,
  threshold)
VALUES (
  '2017-08-30 22:05:00 UTC',
  'XBTEUR',
  'TRIPWIRE',
  3800.0)
