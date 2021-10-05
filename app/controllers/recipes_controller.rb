class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize!, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order('updated_at DESC') 
  end
 
  def new
    @recipe = Recipe.new
  end
 
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_path, notice: "Recipe Created"
    else
      render :new
    end
  end
 
  def show
    id = params[:id]
    @recipe = Recipe.find(id)
    @comment = Comment.new
    @comments = @recipe.comments.order(created_at: :desc)
    @like = @recipe.likes.find_by(user: current_user)

  end
 
  def edit
  end
 
  def update

    id = params[:id]
    @recipe = Recipe.find(id)

    if @recipe.update recipe_params
      redirect_to recipe_path(@recipe), notice: "Recipe Updated"
    else
      render :edit
    end
  end
 
  def destroy

    id = params[:id]
    @recipe = Recipe.find(id)
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe Deleted"
  end
 
  private
 
  def find_recipe
    @recipe = Recipe.find params[:id]
  end
 
  def recipe_params
    params.require(:recipe).permit(:title, :body)
  end

  def authorize! 
    redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @recipe)
  end

end