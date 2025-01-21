class Admin::HomesController < ApplicationController
  def top
    @orders = current_customer.orders.order(created_at: :desc).page(params[:page]).per(10)
  end
end
