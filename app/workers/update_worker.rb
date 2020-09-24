class PostmanWorker
  include Sidekiq::Worker

  def perform(id)
  	interview=Interview.find(id)
  	interview.users.each do |user|
  		UserMailer.user_update(user.email,id).deliver
  	end
  end

end