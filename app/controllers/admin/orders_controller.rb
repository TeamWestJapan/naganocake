class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_orders_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
