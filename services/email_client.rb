require 'mail'

module MailService

  options = {
    :address              => 'smpt.example.com',
    :port                 => 25,
    :user_name            => 'user@example.com',
    :password             => 'password',
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }

  Mail.defaults do
    delivery_method :smtp, options
  end

  def send(sendTo, sendFrom, subject, message)
    Mail.deliver do
       to to
       from from
       subject subject
       body message
    end
  end
end
