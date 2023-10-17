class FoodsController < ApplicationController
  def index
    @user = current_user
    @foods = Food.all.where(user_id: @user.id)
  end

  def show
    @food = Food.find(params[:id])
  end
end
