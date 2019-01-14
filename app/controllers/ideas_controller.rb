class IdeasController < ApplicationController
    def new
        @idea = Idea.new
    end
    def create
        @idea = Idea.new(idea_params)
        # @idea.user = current_user
        if @idea.save
            flash[:success] = "Idea was successfully created"
            redirect_to idea_path(@idea)
        else
            render :new
        end
    end

    def show
        @idea = Idea.find(params[:id])
    end

    private
    def idea_params
        params.require(:idea).permit(:title, :description)
    end
    
end