class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        if session[:user_id].present?
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !!current_user
    end

    def require_user
        unless logged_in?
            flash[:danger] = "You must logged in or sign up first!"
            redirect_to ideas_path
          end
    end


end
