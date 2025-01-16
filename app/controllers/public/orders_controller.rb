class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :index, :create]

  def new
    @order = Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = "{current_customer.last_name} #{current_customer.first_name}"
    @addresses = current_customer.addresses
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
  end

  def create
    @order = Order.new(order_params)
    @order.customer = current_customer
    case params[:order][:shipping_address_type]
    when 'own_address'
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = "#{current_customer.last_name} #{current_customer.first_name}"
    when 'new_address'
      @order.postal_code = params[:order][:shipping_postal_code]
      @order.address = params[:order][:shipping_address]
      @order.name = params[:order][:shipping_name]
    end
    @order.save
      redirect_to thanks_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :address, :postal_code, :name, :shipping_cost, :total_payment)
  end
end
