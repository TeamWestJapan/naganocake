class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:order_id])

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
end
