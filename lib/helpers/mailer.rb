require 'mail'

class Mailer

  def initialize(config)
    config = config.inject({}){ |memo, (k,v)| memo[k.to_sym] = v; memo }
    Mail.defaults do
      delivery_method :smtp, config
    end

    @sender = config[:user_name]
    @recipient = config[:recipient]
  end

  def send(subject, message)
    # https://stackoverflow.com/questions/7928844/why-cant-the-mail-block-see-my-variable
    from = @sender
    to = @recipient

    Mail.deliver do
      from from
      to to
      subject subject
      body message
    end
  end

end
