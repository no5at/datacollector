require 'active_record'

class Trigger < ActiveRecord::Base

  def self.get_fired_triggers(trade_pair, price_history)
    if (price_history.length > 1)
      triggers = Trigger.where trade_pair: trade_pair
      triggers.select do |t|
        f = (price_history[0] - t.threshold) * (price_history[1] - t.threshold)
        f < 0
      end
    else
      []
    end
  end

end
