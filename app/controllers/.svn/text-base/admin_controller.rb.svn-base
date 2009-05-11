class AdminController < ApplicationController
  layout 'layout'
  def index
    
  end
  
  def user_list
    @profiles = Profile.find(:all)
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
end
