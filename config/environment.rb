# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Workwiki::Application.initialize!

if Rails.env.production?
  # only send real emails in production; use Sengrid
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => ENV["COMPANY"] + '.rampupready.com'
  }
  ActionMailer::Base.delivery_method ||= :smtp
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener
end