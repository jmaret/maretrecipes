class IngredientsController < ApplicationController

  before_action :require_user_ingredients, except: [:show]  
  def new
    @ingredient = Ingredient.new
  end
  
  def show
    @ingredient = Ingredient.find(params[:id])
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  private
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def require_user_ingredients 
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to recipes_path
    end
  end
end