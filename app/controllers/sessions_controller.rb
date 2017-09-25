# for implementing session for login and clearing session for logout
class SessionsController < ApplicationController
  before_action :save_login_state, :only => [:login]
  before_action :set_cache_buster	

  def login
  	authorized_user = User.authenticate(params[:email],params[:password])
    if authorized_user
      session[:username] = authorized_user.username
      render :json => @user , :status => 200
    else
      render :json => { :errors => "invalid login" }, :status => 401
    end
  end

  def logout
   session[:username] = nil
   redirect_to :controller =>'user', :action => 'new'
 end
end
