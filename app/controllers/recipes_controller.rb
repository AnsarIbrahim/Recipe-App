class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public_recipes show]
  before_action :set_ability

  def set_ability
    @ability = Ability.new(current_user)
  end

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render 'new'
    end
  end

  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    redirect_to recipes_path
  end

  def update_privacy
    @recipe = Recipe.find(params[:id])
    @recipe.toggle!(:public)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Recipe privacy updated.'
    else
      render 'edit'
    end
  end

  def public_recipes
    @public_recipes = Recipe.includes(:user, recipe_foods: :food).where(public: true)
  end

  def shopping_list
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])

    @shopping_list = []
    @total_value = 0

    @recipe.recipe_foods.each do |recipe_food|
      inventory_food = @inventory.inventory_foods.find_by(food: recipe_food.food)

      if inventory_food.nil?
        quantity_to_buy = recipe_food.quantity
        total_price = quantity_to_buy * recipe_food.food.price
      elsif inventory_food.quantity < recipe_food.quantity
        quantity_to_buy = recipe_food.quantity - inventory_food.quantity
        total_price = quantity_to_buy * recipe_food.food.price
      else
        quantity_to_buy = 0
        total_price = 0
      end

      @shopping_list << [recipe_food.food.name, quantity_to_buy, total_price]
      @total_value += total_price
    end

    @missing_foods = @recipe.recipe_foods.count - @shopping_list.size
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time)
  end
end
