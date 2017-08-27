require 'active_record'

require_relative 'db'
require_relative 'models/ticker_data'
require_relative 'services/kraken_client'

def store(ticker_response)
  pairs = ticker_response['result'].keys

  pairs.each do |pair|
    data = ticker_response['result'][pair]

    t = TickerData.new
    t.trade_pair = pair
    t.ask_price = data['a'][0].to_f
    t.ask_volume = data['a'][2].to_f
    t.bid_price = data['b'][0].to_f
    t.bid_volume = data['b'][2].to_f
    t.last_trade_price = data['c'][0].to_f
    t.last_trade_volume = data['c'][1].to_f
    t.save
  end
end

kraken = Kraken::Client.new()
while true do
  begin
    store(kraken.ticker('XBTEUR,BCHEUR'))
  rescue
    puts 'Error fetching current rates'
  end

  sleep 5 * 60
end
