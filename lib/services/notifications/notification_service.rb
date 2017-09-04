require_relative "../../models/trigger"

class NotificationService

  def initialize(mailer)
    @mailer = mailer
  end

  def notify_if_needed(ticker_info_list)
    triggers = ticker_info_list.flat_map do |info|
      notify(info, Trigger::get_fired_trigger(info.trade_pair))
    end
  end

  def notify(ticker_info, fired_triggers)
    notification = {
      "subject" => "A Notification!",
      "message" => "Just a notification, to be completed later"
    }

    @mailer.send(notification["subject"], notification["message"])
  end

end
