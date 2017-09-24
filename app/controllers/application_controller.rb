class ApplicationController < ActionController::Base
  protected
  def authenticate_user
    if session[:username]
      p session[:username]
      @current_user = User.find_by(username:session[:username])
      return true
    else
      redirect_to(:controller => 'user', :action => 'new')
      return false
    end
  end
  def save_login_state
    if session[:username]
      redirect_to(:controller => 'posts', :action => 'new')
      return false
    else
      return true
    end
  end
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
