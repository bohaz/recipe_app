class PublicRecipesController < ApplicationController
  def index
    @user = current_user
    @recipes = Recipe.all
  end
end
