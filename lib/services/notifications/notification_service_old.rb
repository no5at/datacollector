require 'mail'

require_relative '../models/ticker_data'
require_relative '../models/trigger'

class NotificationService

  def initialize(smtp_opts, config)
    @config = config

    smtp_opts = smtp_opts.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    Mail.defaults do
      delivery_method :smtp, smtp_opts
    end
  end

  def self.get_firing_notifications(trade_pair)
    recent_ticker_data =
      TickerData
        .where(trade_pair: trade_pair)
        .order(created_at: :desc)
        .limit(2)

    recent_price = recent_ticker_data.map { |t| t.last_trade_price }

    if (recent_price.length == 2)
      triggers = Trigger.where trade_pair: trade_pair
      triggers.select do |t|
        f = (recent_price[0] - t.threshold) * (recent_price[1] - t.threshold)
        f < 0
      end
    else
      []
    end
  end

  def notify(ticker_data)
    sender = @config['sender']
    recipient = @config['recipient']
    subject = '[NOTIFICATION] ' + ticker_data.map { |t| t.trade_pair }.join(', ')

    Mail.deliver do
      from sender
      to recipient
      subject subject
      body 'Just a dummy message'
    end
  end
end
