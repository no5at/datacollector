require 'rack/test'
require 'test/unit'

require_relative '../../services/notification_service'

class NotificationServiceSpec < Test::Unit::TestCase
  include Rack::Test::Methods

  config = YAML::load_file('conf/conf.yaml')
  db = ActiveRecord::Base.establish_connection(config['db.test'])

  puts 'Initializing test DB'
  statements = File.read('conf/schema_sqlite3.sql').strip.split(';')
  statements.each do |sql|
    db.connection.execute (sql << ';').strip
  end

  puts 'Loading fixtures'
  statements = File.read('test/fixtures.sql').strip.split(';')
  statements.each do |sql|
    db.connection.execute (sql << ';').strip
  end

  def test_should_notify
    puts 'Testing notification_service::should_notify?'
    notifications = NotificationService::get_firing_notifications('XBTEUR')
    puts notifications.length
    puts notifications
  end

end
