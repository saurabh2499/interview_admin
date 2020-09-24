class InterviewsController < ApplicationController
	def index
	  @interviews = Interview.order('created_at DESC')
	end

	def new
	  @interview = Interview.new
	  @users = User.all
      @selected = Array.new
	end

	def create
	  @interview= Interview.new(interview_params)
 	  part=params[:interview][:participants]
 	  @users=User.all
 	  unless part.nil?
 	    part.delete_at(0)
 	    @selected= User.select(:id).find(part)
 	  else
 	  	@selected=Array.new
 	  end
 	  @interview.user_ids = part
 	  if @interview.save
 	  	PostmanWorker.perform_async(@interview.id)
 	  	ReminderWorker.perform_at(@interview.startTime- 30.minutes,@interview.id)
  		redirect_to interviews_path
      else
  		render 'new'
  	  end
	end

	def update
  	  @interview = Interview.find(params[:id])
  	  @users=User.all
  	  part=params[:interview][:participants]
  	  unless part.nil?
 	    part.delete_at(0)
 	    @selected= User.select(:id).find(part)
 	  else
 	  	@selected=Array.new
 	  end
 	  @interview.user_ids = part
	  if @interview.update(interview_params)
	  	UpdateWorker.perform_async(@interview.id)
	  	ReminderWorker.perform_at(@interview.startTime-30.minutes, @interview.id)
    	redirect_to interviews_path
  	  else
    	render 'edit'
  	  end
	end


	def edit
	  @interview = Interview.find(params[:id])
	  @users=User.all
	  @selected= @interview.users.select(:id)
	end

	def destroy
	  @interview = Interview.find(params[:id])
	  @interview.destroy
	  delete_previous_scheduled_jobs(@interview.id)
	  redirect_to interviews_path
	end

	private
  		def interview_params
    	  params.require(:interview).permit(:startTime, :endTime, :resume)
  		end
end
