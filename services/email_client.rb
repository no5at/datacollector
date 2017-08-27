require 'mail'

#module MailService
  options = {
    :address              => 'example.com',
    :port                 => 25,
    :user_name            => 'user@example.com',
    :password             => 'password',
    :authentication       => :login,
    :tls                  => true
  }

  Mail.defaults do
    delivery_method :smtp, options
  end

  #def send(sendTo, sendFrom, subject, message)
    Mail.deliver do
       to to
       from from
       subject subject
       body body
    end
  #end
#end
