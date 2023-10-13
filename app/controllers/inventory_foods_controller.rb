class InventoryFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @inventory_food = InventoryFood.new
    @inventory = Inventory.find(params[:inventory_id])
  end

  def create
    @inventory_food = InventoryFood.new(inventory_food_params)
    @inventory_food.inventory_id = params[:inventory_id]

    if @inventory_food.save
      redirect_to inventory_path(params[:inventory_id]), notice: 'Food added to inventory'
    else
      render :new
    end
  end

  # inventory_foods_controller.rb
  def destroy
    @inventory_food = InventoryFood.find(params[:id])
    @inventory = @inventory_food.inventory

    if @inventory_food.destroy
      redirect_to inventory_path(@inventory), notice: 'Food removed from inventory.'
    else
      redirect_to inventory_path(@inventory), alert: 'Unable to remove food from inventory.'
    end
  end

  private

  def inventory_food_params
    params.require(:inventory_food).permit(:quantity, :food_id)
  end
end
