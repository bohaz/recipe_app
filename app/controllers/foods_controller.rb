class FoodsController < ApplicationController
  def index
    @user = current_user
    @foods = Food.all.where(user_id: @user.id)
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @user = current_user
    @food = Food.new
  end

  def create
    @user = current_user
    @food = Food.new(food_params)
    @food.user_id = @user.id
    if @food.save
      redirect_to foods_path
    else
      render :new
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
