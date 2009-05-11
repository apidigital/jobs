class FrontController < ApplicationController
layout 'layout'
skip_before_filter :admin_check, :only => [:index]
  def index
    #@positions = Position.find(:all)
    @categories = Category.find(:all)
    if current_user && current_user.admin?
      @positions = Position.paginate :page => params[:page], :per_page => 5, :order => 'updated_at DESC'
    else
      @positions = Position.paginate :page => params[:page], :per_page => 5, :order => 'updated_at DESC', :conditions => { :active => true }
    end
  end
end
