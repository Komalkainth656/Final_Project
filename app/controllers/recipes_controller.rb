class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :edit, :update, :destroy]
 
  def index
    @recipes = Recipe.all
  end
 
  def new
    @recipe = Recipe.new
  end
 
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: "Recipe Created"
    else
      render :new
    end
  end
 
  def show
  end
 
  def edit
  end
 
  def update
    if @recipe.update recipe_params
      redirect_to @recipe, notice: "Recipe Updated"
    else
      render :edit
    end
  end
 
  def destroy
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
 
end