require 'rack/test'
require 'test/unit'

require_relative '../../lib/helpers/db'

class TriggerSpec < Test::Unit::TestCase
  include Rack::Test::Methods


  def test_fired_triggers
    db = DB.new({ 'adapter' => 'sqlite3', 'database' => 'tmp/db_trigger_spec.sqlite' })

    # trigger = Trigger.new
    # trigger.trade_pair = B,
    # trigger_type TEXT,
    # threshold REAL

    db.drop_database
  end

end
