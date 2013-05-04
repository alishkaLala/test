class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  
  protected
  
    def authorize
      unless Staff.find_by_id(session[:staff_id])
        redirect_to log_url, notice: "log, please"
      end
    end
    
    def any_log
      session[:staff_id]
    end
    
    def admin_log
      session[:admin_id]
    end
    
end
