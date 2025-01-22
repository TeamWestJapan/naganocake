class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :index, :confirm, :show, :thanks, :create]

  def new
    @order = Order.new
  end

  def thanks
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details= OrderDetail.where(order_id: @order.id)
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_cost = 800
    ary = []
    @cart_items.each do |cart_item|
      ary <<cart_item.item.price*cart_item.amount
    end
    @cart_items_price = ary.sum
    @total_price = @shipping_cost + @cart_items_price
    @address_type = params[:order][:address_type]
    case @address_type
    when "own_address"
      @order.postal_code = current_customer.postal_code 
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when "saved_address"
      unless params[:order][:saved_address_id] == ""
        @address = Address.find(params[:order][:saved_address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      else
        render :new
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    if @order.save
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.with_tax_price, amount: cart_item.amount, making_status: 0)
        end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :address, :postal_code, :name, :shipping_cost, :total_payment, :status)
  end
end
