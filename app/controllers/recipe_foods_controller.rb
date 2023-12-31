class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @available_foods = available_foods_for_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    if @recipe_food.save
      redirect_to @recipe_food.recipe, notice: 'Ingredient added successfully.'
    else
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe_food.recipe), notice: 'Ingredient was successfully removed.'
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @available_foods = Food.includes(:user).where(user_id: current_user.id)
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      redirect_to @recipe_food.recipe, notice: 'Ingredient quantity was successfully updated.'
    else
      render :edit
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity)
  end

  def available_foods_for_recipe
    # Get the foods that are not used in the current recipe
    recipe = Recipe.find(params[:recipe_id])
    used_food_ids = recipe.recipe_foods.pluck(:food_id)
    Food.includes(:user).where(user_id: current_user.id).where.not(id: used_food_ids)
  end
end
