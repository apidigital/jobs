# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_jobs_session_id'
  
  before_filter :load_categories_for_sidebar, :admin_check
  
  helper_method :context
  def context
    if params[:position_id]
      Position.find(params[:position_id])
    end
  end
   
   
   
  private
  
  def admin_check
    unless current_user && current_user.profile.admin?
      flash[:notice] = "You are not authorized for that action."
      redirect_to('/')
    end
  end
  
  def load_categories_for_sidebar
    unless read_fragment('sidebar')
      @sidebar_categories = Category.find(:all)
    end
  end
end
