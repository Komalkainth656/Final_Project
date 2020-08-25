class CommentsController < ApplicationController
    def create
        @recipe = Recipe.find params[:recipe_id]
        comment_params = params.require(:comment).permit(:body)
        @comment = Comment.new comment_params
        @comment.recipe  = @recipe
        @comment.user = current_user
        if @comment.save
          redirect_to recipe_path(@recipe), notice: "Comment created"
        else
          @comments=@recipe.comments.order(created_at: :desc)
          render "/recipes/show"
        end
      end

      def destroy 
        @comment = Comment.find params[:id]
        if can?(:crud, @comment)
            @comment.destroy 
            redirect_to recipe_path(@comment.recipe)
        else 
            head :unauthorized
        end
    end
end
