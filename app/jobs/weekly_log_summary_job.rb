class WeeklyLogSummaryJob < ApplicationJob
  queue_as :mailers

  def perform(user_id)
    user = User.find(user_id)
    UserMailer.weekly_log_summary(user).deliver_later
  end
end
