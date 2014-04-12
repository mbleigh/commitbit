require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
if ENV['MANDRILL_USERNAME']
  ActionMailer::Base.delivery_method = :smtp
  
  ActionMailer::Base.smtp_settings = {
    :port      => 587,
    :address    => "smtp.mandrillapp.com",
    :authentication => :plain,
    :user_name      => ENV['MANDRILL_USERNAME'],
    :password       => ENV['MANDRILL_APIKEY'],
  }
else
  ActionMailer::Base.delivery_method = :test
end

ActionMailer::Base.view_paths = File.dirname(__FILE__) + '/../../mail'