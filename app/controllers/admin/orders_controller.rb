class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:show, :update]

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end


  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "payment_confirm"
      @order.order_details.update_all(making_status: "waiting_for_production")
    end
    if @order.update(order_params)
      if @order.order_details.where(making_status: "produced").count == @order.order_details.count
        # すべて "produced" なら Order の status を "preparing_for_shipping" に更新
        @order.update(status: "preparing_for_shipping")
      end
    end
    redirect_to request.referer
  end
    
  private

  def order_params
    params.require(:order).permit(:status)
  end
end
