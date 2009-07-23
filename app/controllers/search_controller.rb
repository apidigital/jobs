class SearchController < ApplicationController
  
  skip_before_filter :admin_check
  
  def search
  	@categories = Category.find(:all)
    @positions = Position.find(:all, :conditions => ["name like :query or description like :query", {:query => "%#{params[:query]}%"}])
    render :template => "positions/index"
  end

end
