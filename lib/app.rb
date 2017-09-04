require_relative "helpers/db"
require_relative "helpers/logging"
require_relative "helpers/mailer"
require_relative "models/ticker_info"
require_relative "services/kraken/kraken_client"
require_relative "services/notifications/notification_service"

config = YAML::load_file("config/conf.yaml")
db = DB.new(config["db"])
kraken = Kraken::Client.new()
notification_service = NotificationService.new(Mailer.new(config["mailer"]))
logger = LogHelper::get_logger

def parse_ticker_response(r)
  pairs = r["result"].keys

  pairs.map do |pair|
    data = r["result"][pair]

    t = TickerInfo.new do |t|
      t.trade_pair = pair
      t.ask_price = data["a"][0].to_f
      t.ask_volume = data["a"][2].to_f
      t.bid_price = data["b"][0].to_f
      t.bid_volume = data["b"][2].to_f
      t.last_trade_price = data["c"][0].to_f
      t.last_trade_volume = data["c"][1].to_f
      t.save
    end
  end
end

while true do
  begin
    logger.info "Fetching ticker info"
    ticker_info_list = parse_ticker_response(kraken.ticker("XBTEUR,BCHEUR"))
    logger.debug "Ticker info stored"
    logger.debug "Calling notification service"
    was_notified = notification_service.notify_if_needed(ticker_info_list)
    if (was_notified)
      logger.info "Notification sent"
    else
      logger.info "No notification sent"
    end
  rescue => e
    logger.warn 'Error fetching current rates'
    logger.warn e
  end

  sleep 5 * 60
end
