class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged_in?
    helper_method :set_user_global
    def current_user
        @current_user ||= User.find(session[:user_id]) if  session[:user_id]
    end
    def logged_in?
        !!current_user 
    end
    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end    
    end

    def set_user_global
        if !@user
            @user = User.new
        end
    end
end
