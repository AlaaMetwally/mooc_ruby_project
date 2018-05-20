class ApplicationMailer < ActionMailer::Base
  default from: 'alaametwally48@gmail.com'
  def spam_email(user,lecture,current_user)
    @user = user
    @lecture = lecture
    @current_user = current_user
    mail(to: @user.email, subject: 'Spammed Lecture')
  end
end
