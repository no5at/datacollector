require 'active_record'

class TickerData < ActiveRecord::Base
  self.table_name = "ticker_data"
end
