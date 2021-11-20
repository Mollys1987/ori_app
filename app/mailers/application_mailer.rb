class ApplicationMailer < ActionMailer::Base
  default from: ENV['ADD']
  layout 'mailer'
end
