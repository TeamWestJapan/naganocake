class Admin::OrdersController < ApplicationController
  

  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:order_id])
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
