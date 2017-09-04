require "rack/test"
require "test/unit"

require_relative "../../lib/helpers/db"
require_relative "../../lib/services/notifications/notification_service"

class MockMailer
  attr_accessor :last_subject, :last_message

  def send(subject, message)
    @last_subject = subject
    @last_message = message
  end

end

class NotificationServiceSpec < Test::Unit::TestCase
  include Rack::Test::Methods

  class << self
    def startup
      @db = DB.new({ "adapter" => "sqlite3", "database" => "tmp/test_notification_service_spec.sqlite" })

      @TICKER_INFO = TickerInfo.new do |t|
        t.trade_pair = "XBTEUR"
        t.ask_price = 3801.0
        t.ask_volume = 1.0
        t.bid_price = 3801.0
        t.bid_volume = 1.0
        t.last_trade_price = 3801.0
        t.last_trade_volume = 1.0
      end

      @FIRED_TRIGGER = Trigger.new do |t|
        t.trade_pair = "XBTEUR"
        t.trigger_type = "TRIPWIRE"
        t.threshold = 3800.0
      end
    end

    def shutdown
      @db.drop_database
    end
  end

  def test_notify
    mock_mailer = MockMailer.new

    service = NotificationService.new(mock_mailer)
    service.notify(@TICKER_INFO, [ @FIRED_TRIGGER ])

    # TODO test if mailer sent out the correct notification
    # assert_equal "SUBJECT", mailer.last_subject
    # assert_equal "Just testing", mailer.last_message
  end

end
