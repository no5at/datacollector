require 'rack/test'
require 'test/unit'

require_relative '../../lib/helpers/db'

class TriggerSpec < Test::Unit::TestCase
  include Rack::Test::Methods


  def test_fired_triggers
    db = DB.new({ 'adapter' => 'sqlite3', 'database' => 'tmp/db_trigger_spec.sqlite' })

    # Load fixtures, so that we have price history

    # Add multiple triggers

    # Check if the correct ones fire

    # trigger = Trigger.new
    # trigger.trade_pair = "XBTEUR"
    # trigger_type = "TRIPWIRE"
    # threshold = 3800.0

    db.drop_database
  end

end
