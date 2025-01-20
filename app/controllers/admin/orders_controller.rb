class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @customer = Customer.find(@order.customer_id)
    @items = Item.find(@customer.id)
    @order_detail = OrderDetail.find(params[:order.id])
    @order_detail.amount = @items.amount
    @order_detail.price = @items.items.price * 1.1
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    @order = Order.find(params[:id])
    @order_status = [:order][:order_status]
    case @order_status
    when "入金待ち"
      @order.status = 0
    when "入金確認"
      @order.status = 1
    when "製作中"
      @order.status = 2
    when "発送準備"
      @order.status = 3
    else "発送済み"
      @order.status = 4
    end
    
    @order.update(order_params)
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
