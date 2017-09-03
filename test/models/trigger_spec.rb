require "rack/test"
require "test/unit"

require_relative "../../lib/helpers/db"
require_relative "../../lib/models/trigger"

class TriggerSpec < Test::Unit::TestCase
  include Rack::Test::Methods


  def test_fired_triggers
    db = DB.new({ "adapter" => "sqlite3", "database" => "tmp/test_db_trigger_spec.sqlite" })
    db.load_fixtures("test/fixtures.sql")

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

    fired = Trigger::get_fired_triggers("XBTEUR")

    # TODO check if correct

    db.drop_database
  end

end
