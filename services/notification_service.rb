require 'mail'

class NotificationService

  def initialize(smtp_opts, config)
    @config = config

    smtp_opts = smtp_opts.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    Mail.defaults do
      delivery_method :smtp, smtp_opts
    end
  end

  def notify(ticker_data)
    sender = @config['sender']
    recipient = @config['recipient']
    subject = '[NOTIFICATION] ' + ticker_data.map { |t| t.trade_pair }.join(', ')

    Mail.deliver do
      from sender
      to recipient
      subject subject
      body 'Just a dummy message'
    end
  end
end
