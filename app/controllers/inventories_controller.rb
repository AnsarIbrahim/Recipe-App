class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ability

  def set_ability
    @ability = Ability.new(current_user)
  end

  def new; end

  def index
    @inventories = Inventory.where(user_id: current_user.id)
  end

  def show
    @inventory = Inventory.includes(inventory_foods: :food).find(params[:id])
  end

  def destroy
    Inventory.find(params[:id]).destroy
    redirect_to inventories_path, notice: 'Inventory deleted'
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.user_id = current_user.id

    if @inventory.save
      redirect_to inventories_path, notice: 'Inventory successfully added'
    else
      render :new, notice: 'Failed'
    end
  end

  private

  def inventory_params
    params.permit(:name, :description)
  end
end
