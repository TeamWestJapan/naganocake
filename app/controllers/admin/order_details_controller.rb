class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    is_updated = true
      if @order_detail.update(order_detail_params)
        @order.update(status: "in_production") if @order_detail.making_status == "in_production"
        @order_details.each do |order_detail| 
          if order_detail.making_status != "produced"
            is_updated = false 
          end
       end
       @order.update(status: "preparing_for_shipping") if is_updated
    end
    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
end
