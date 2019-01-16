class ReviewsController < ApplicationController
    before_action :set_review,only:[ :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:destroy]
   
    def create
    @idea = Idea.find(params[:idea_id])
    @review = Review.new(review_params)
    @review.idea = @idea
    @review.user = current_user
    
        if @review.save
            redirect_to idea_path(@idea.id)
        else
            @reviews = @idea.reviews.order(created_at: :desc)
            render "ideas/show"
        end
    end
   
    def destroy
        @review = Review.find params[:id]
        @review.destroy

        redirect_to idea_path(@review.idea)
    end

    private
    def set_review
        @review = Review.find(params[:id])
    end

    def review_params
        params.require(:review).permit(:body)
    end

    def require_same_user
        if current_user != @review.user
            flash[:danger] = "You can edit/delete only your own reviews"
            redirect_to idea_path(@review.idea)
        end
    end
end