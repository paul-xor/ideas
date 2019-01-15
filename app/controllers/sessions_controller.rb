class SessionsController < ApplicationController
    def new

    end

    def create
        
        user = User.find_by_email params[:email]
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success]='You have successfully logged in'
            redirect_to ideas_path
        else
            flash.now[:danger]='There was something wrong with your login'
            render "new"
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = 'You have logged out'
        redirect_to ideas_path
    
    end

end