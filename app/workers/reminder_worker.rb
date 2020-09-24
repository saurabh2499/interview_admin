class ReminderWorker
  include Sidekiq::Worker

  def perform(id)
  	interview=Interview.find(id)
    if interview.startTime-Time.now<=30.minutes && intreview.startTime - Time.now >=25.minutes
  	  interview.users.each do |user|
  		  UserMailer.user_reminder(user.email,id).deliver
  	  end
    end
  end
end