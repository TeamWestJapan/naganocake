class Admin::OrderDetailsController < ApplicationController
  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(@order.id)
    @order_detail.update(order_detail_params)
    redirect_to request.referer
  end
  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
end
