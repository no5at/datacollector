require "rack/test"
require "test/unit"

require_relative "../../lib/helpers/db"
require_relative "../../lib/models/trigger"

class TriggerSpec < Test::Unit::TestCase
  include Rack::Test::Methods

  class << self
    def startup
      @db = DB.new({ "adapter" => "sqlite3", "database" => "tmp/test_trigger_spec.sqlite" })

      puts "Loading ticker history fixtures"
      @db.load_fixtures("test/fixtures.sql")

      puts "Inserting test triggers"
      def create_triggers(trade_pair, thresholds)
        thresholds.each do |threshold|
          trigger = Trigger.new
          trigger.trade_pair = trade_pair
          trigger.trigger_type = "TRIPWIRE"
          trigger.threshold = threshold
          trigger.save
        end
      end

      create_triggers("XBTEUR", [ 3700, 3800, 3900 ])
      create_triggers("BCHEUR", [ 480, 500, 520 ])
    end

    def shutdown
      @db.drop_database
    end
  end

  def test_fired_triggers
    fired_xbteur = Trigger::get_fired_trigger("XBTEUR")
    assert fired_xbteur
    assert_equal 3800.0, fired_xbteur.threshold

    fired_bcheur = Trigger::get_fired_trigger("BCHEUR")
    assert fired_bcheur
    assert_equal 500, fired_bcheur.threshold
  end

end
