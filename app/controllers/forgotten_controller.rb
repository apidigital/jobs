require 'digest/md5'
class ForgottenController < ApplicationController
  layout 'layout'
  skip_before_filter :admin_check, :only => [:sendmail, :reset]
  def sendmail
  	recipient = params[:email]
    user = User.find_by_email(recipient)
    if user
      newpass = Digest::MD5.hexdigest(Time.now.to_i.to_s)[0..15]
      flash[:notice] = 'User was found.'
      user.password = newpass
      user.password_confirmation = newpass
      user.save
      content = newpass
      uname = user.login
      Forgotten.deliver_confirm(recipient, content, newpass, uname)
    else
      flash[:notice] = 'User not found.'
    end
  end
  
  def reset
    
  end
end
