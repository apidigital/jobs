class AdminController < ApplicationController
  def index
    
  end
  
  def user_list
    @users = User.find(:all)
  	@admins = Array.new
  	@users.each do |user|
	  	if user.profile.admin == 1
	  		@admins << user
	  	end
	  end
  end

  def positions
    @positions = Position.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @positions }
    end
  end
  
  def checked
    @submissions = Submission.checked
  end
  
  def unchecked
    @submissions = Submission.unchecked
  end
  
  def pending_interviews
  	@submissions = Submission.interview_step
  	@submissions_for_day = Submission.scheduled_interviews
  end
  
  def scheduler
  	@submissions = Submission.scheduled_interviews
  end
  
  def get_interviews
  	@submissions = Submission.scheduled_interviews
  	render :partial => "scheduler_daylist", :object => @submissions, :locals => {:formtime => params[:date]}
  end
end
