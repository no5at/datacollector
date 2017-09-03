require "rack/test"
require "test/unit"

require_relative "../../lib/services/kraken/kraken_client"

class TriggerSpec < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_api_connectivity
      # Just test if no exception happens
      kraken = Kraken::Client.new()
      time = kraken.server_time
    end

end
