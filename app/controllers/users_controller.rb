class UsersController < ApplicationController
    before_action :set_user, only:[:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        # debugger
        @user = User.new(user_params)

        if @user.save
            #session[:user_id] = @user.id
            flash[:success] = "Welcome to the ideas app #{@user.username}"
            redirect_to ideas_path
        else
            render :new
        end
    end
    def edit
        
    end

    def update
        if @user.update(user_params)
            flash[:success] = "#{@user.username} account was updated successfully"
            redirect_to ideas_path
        else
            render :edit
        end

    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User and all ideas created by user have been deleted"
        redirect_to users_path
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    def set_user
        @user = User.find(params[:id])
    end
    def require_same_user
        if current_user != @user 
            flash[:danger] = "You can edit only your own account"
            redirect_to root_path
        end
    end
end