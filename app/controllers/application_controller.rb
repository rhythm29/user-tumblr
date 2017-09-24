class ApplicationController < ActionController::Base
  protected 
	def authenticate_user
  	p "LOVE CHARGER"
    p session[:username]  			       		  		  	
	  if session[:username]
	     # set current user object to @current_user object variable
  		p "hum yaha tak pahuche hai"
        p session[:username]  			     
	    @current_user = User.find_by(username:session[:username])
	    return true	
	  else
	    redirect_to(:controller => 'user', :action => 'new')
	    return false
	  end
	end
  	def save_login_state
  		p "save_login_state"
        p session[:username]  			       		  		
	  if session[:username]	  	
	    redirect_to(:controller => 'posts', :action => 'new')
	    return false
	  else
	    return true
	  end
	end
  def set_cache_buster
  	p "KAR DIYA CLEAR"
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
