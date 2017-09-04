require_relative "../../models/trigger"

class NotificationService

  def initialize(mailer)
    @mailer = mailer
  end

  def notify_if_needed(ticker_info_list)
    sent = false

    ticker_info_list.flat_map do |info|
      trigger = Trigger::get_fired_trigger(info.trade_pair)
      if (trigger)
        sent = true
        notify(info, trigger)
      end
    end

    sent
  end

  def notify(ticker_info, fired_trigger)
    notification = {
      "subject" => "A Notification!",
      "message" => "Just a notification, to be completed later"
    }

    @mailer.send(notification["subject"], notification["message"])
  end

end
