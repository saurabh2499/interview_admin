class UserMailer < ApplicationMailer
	default :from =>"abc@example.com"

	def user_welcome(email,interview)
		@email=email
		@url="example.com"
		@interview=Interview.find(interview)
		mail(:to => @email,
			:subject => "Welcome to abc.com")
	end
	
	def user_update(email,interview)
		@email=email
		@interview=Interview.find(interview)
		mail(:to => @email,
			 :subject => "Interview updates")
	end
	
	def interview_reminder(email,interview)
		@email=email
		@url="example.com"
		@interview=Interview.find(interview)
		mail(:to => @email,
			:subject => "interview reminder")
	end
end
