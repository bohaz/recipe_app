class PublicRecipesController < ApplicationController
  def index
    @user = current_user
    @public_recipes = Recipe.where(public: true)
  end
end
