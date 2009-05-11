class UsersController < ApplicationController
  layout 'layout'
  # Be sure to include AuthenticationSystem in Application Controller instead
  skip_before_filter :admin_check, :only => [:create, :new, :change_password, :change_password_update]
  

  # render new.rhtml
  def new
    @profiles = Profile.new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.build_profile(params[:profile])
    
    if @user.save
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

  #
  # Change user passowrd
  def change_password

  end


  #
  # Change user passowrd
  def change_password_update
      if User.authenticate(current_user.login, params[:old_password])
          if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
              current_user.password_confirmation = params[:password_confirmation]
              current_user.password = params[:password]

              if current_user.save
                  flash[:notice] = "Password successfully updated"
                  redirect_to change_password_path
              else
                  flash[:notice] = "Password not changed"
                  #render :action => 'change_password'
                  redirect_to change_password_path
              end

          else
              flash[:notice] = "New Password mismatch" 
              #render :action => 'change_password'
              redirect_to change_password_path
          end
      else
          flash[:notice] = "Old password incorrect" 
          #render :action => 'change_password'
          redirect_to change_password_path
      end
  end
end
