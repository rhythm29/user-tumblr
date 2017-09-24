class UserController < ApplicationController
  before_action :save_login_state, :only => [:new, :create]
  before_action :set_cache_buster 
  
  def new
    @user = User.new 
  end

  def create
    params_received = user_params
    params_received[:password_confirmation] = params[:password_confirmation]
    p params_received
    @user = User.new(params_received)
    p @user.password
     if @user.save
      p @user.password
      # redirect_to :controller => 'posts', :action => 'index'
      render :json => @user , :status => 200
     else
      p @user.errors.details
      render :json => { :errors => @user.errors.details }, :status => 422
       # render new
     end
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
