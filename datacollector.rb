require 'yaml'
require 'active_record'

require_relative 'models/ticker_data'
require_relative 'services/kraken_client'
require_relative 'services/notification_service'

config = YAML::load_file('conf/conf.yaml')

db = ActiveRecord::Base.establish_connection(config['db'])

if (!db.connection.table_exists? 'ticker_data')
  puts 'Empty database - initializing'
  statements = File.read('conf/schema_sqlite3.sql').strip.split(';')
  statements.each do |sql|
    db.connection.execute (sql << ';').strip
  end
end

# Kraken client
kraken = Kraken::Client.new()

# E-Mail client/notification service
notification_service = NotificationService.new(config['smtp'], config['notifications'])

def store(ticker_response)
  pairs = ticker_response['result'].keys

  pairs.map do |pair|
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
    t
  end
end

while true do
  begin
    ticker_data = store(kraken.ticker('XBTEUR,BCHEUR'))
    # TODO check DB for rule-based notification triggers
    notification_service.notify(ticker_data)
  rescue => e
    puts 'Error fetching current rates'
    puts e
  end

  sleep 5 * 60
end
