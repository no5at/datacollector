require "active_record"

require_relative "ticker_info"

class Trigger < ActiveRecord::Base

  def self.get_fired_trigger(trade_pair)
    ticker_history = TickerInfo
      .where(trade_pair: trade_pair)
      .order(created_at: :desc)
      .limit(2)

    price_history = ticker_history.map { |t| t.last_trade_price }

    if (price_history.length > 1)
      triggers = Trigger.where trade_pair: trade_pair
      if (triggers.length > 0)
        fired = triggers.select do |t|
          f = (price_history[0] - t.threshold) * (price_history[1] - t.threshold)
          f < 0
        end

        # TODO pick highest priority

        fired[0]
      end
    end
  end

end
