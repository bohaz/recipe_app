class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.includes(:foods, :recipes).find(params[:id])
  end

  def new
    @user = current_user
  end
end
