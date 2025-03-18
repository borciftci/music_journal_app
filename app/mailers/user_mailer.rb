class UserMailer < ApplicationMailer
  default from: "no-reply@musicjournal.com"

  def weekly_log_summary(user)
    @user = user
    @music_logs = user.music_logs.where(date: 1.week.ago.to_date..Date.today)

    mail(to: @user.email, subject: "Your Weekly Log Summary")
  end
end
