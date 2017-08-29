require 'rack/test'
require 'test/unit'

require_relative '../../services/notification_service'

class NotificationServiceSpec < Test::Unit::TestCase
  include Rack::Test::Methods

  config = YAML::load_file('conf/conf.yaml')
  ActiveRecord::Base.establish_connection(config['db'])

  def test_should_notify
    puts 'Testing notification_service::should_notify?'

    # t = Trigger.new
    # t.trade_pair = 'BCHEUR'
    # t.trigger_type = 'TRIPWIRE'
    # t.threshold = 3800
    # t.save

    NotificationService::should_notify?('BCHEUR', 'bar')
  end

end
