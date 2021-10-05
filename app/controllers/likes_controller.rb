class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy] 
 
  def create
    recipe = Recipe.find params[:recipe_id]
    like = Like.new(recipe: recipe, user: current_user)

    if !can?(:like, recipe)
        flash[:danger] = "You can't like your own recipe...."
      elsif like.save
        flash[:success] = "Recipe Liked"
      else
        flash[:danger] = like.errors.full_messages.join(", ")
      end
      redirect_to recipe_path(recipe)
  end
 
  def destroy
    like = current_user.likes.find params[:id]
    like.destroy
    redirect_to recipe_path(like.recipe), notice: "Unliked"
  end
 

end
