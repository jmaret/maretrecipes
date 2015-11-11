class StylesController < ApplicationController

  before_action :require_user_styles, except: [:show]
  
  def new
    @style = Style.new
  end
  
  def show
    @style = Style.find(params[:id])
    @recipes = @style.recipes.paginate(page: params[:page], per_page: 4)
  end
  
  def create
    @style = Style.new(style_params)
    if @style.save
      flash[:success] = "Style was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  private
  def style_params
    params.require(:style).permit(:name)
  end
  
  def require_user_styles
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to recipes_path
    end
  end
end