class CommentsController < ApplicationController
    def create
        @recipe = Recipe.find params[:recipe_id]
        comment_params = params.require(:comment).permit(:body)
        @comment = Comment.new comment_params
        @comment.recipe  = @recipe
        if @comment.save
          redirect_to recipe_path(@recipe), notice: "Comment created"
        else
          render "/recipes/show"
        end
      end
end
