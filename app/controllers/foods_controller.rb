class FoodsController < ApplicationController
  before_action :authenticate_user!

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to new_food_path, notice: 'Food successfully added'
    else
      render :new, notice: 'Failed'
    end
  end

  def new; end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    # redirect_to foods_path, notice: 'Food deleted successfully'
  end

  private

  def food_params
    params.permit(:name, :measurement_unit, :price)
  end
end
