require_relative "../../models/trigger"

class NotificationService

  def initialize(mailer)
    @mailer = mailer
  end

  def notify_if_needed(ticker_info_list)
    triggers = ticker_info_list.flat_map do |info|
      Ticker::get_fired_triggers(info.trade_pair)
    end

    triggers.each do |trigger|
      notification = create_notification(trigger)
      mailer.send(notification["subject"], notification["message"])
    end
  end

  private
    # TODO dummy only
    def create_notification(trigger)
      {
        "subject" => "A Notification!",
        "message" => "Just a notification, to be completed later"
      }
    end

end
