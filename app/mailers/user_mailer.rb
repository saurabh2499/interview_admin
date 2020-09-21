class UserMailer < ApplicationMailer
	default :from =>"abc@example.com"

	def user_update(user,interview)
		@user=user
		@interview=interview
		mail(:to => user.email,
			 :subject => "Interview updates")
	end
	def user_welcome(user,interview)
		@user=user
		@url="example.com"
		@interview=interview
		mail(:to => user.email,
			:subject => "Welcome to abc.com")
	end
	def interview_reminder(user,interview)
		@user=user
		@url="example.com"
		@interview=interview
		mail(:to => user.email,
			:subject => "interview reminder")
	end
end
