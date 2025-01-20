class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:order.id][:id])
    @detail_status = [:order][:order_detail][:detail_status]
    case @detail_status
    when "製作不可"
      @order_detail.making_status = 0
    when "製作待ち"
      @order_detail.making_status = 1
    when "製作中"
      @order_detail.making_status = 2
    else "製作完了"
      @order_detail.making_status = 3
    end
    @order_detail.update(order_detail_params)
    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
end
