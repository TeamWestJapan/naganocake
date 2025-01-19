class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :index, :confirm, :show, :thanks, :create]

  def new
    @order = Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = "#{current_customer.last_name} #{current_customer.first_name}"
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
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_cost = 800
    #ary = []
    #@cart_items.each do |cart_item|
      #ary <<cart_item.item.price*cart_item.quantity
    #end
    #@cart_items_price = ary.sum
    @address_type = params[:order][:address_type]
    case @address_type
    when "own_address"  # 自身の住所を使う場合
      @order_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
    when "saved_address"  # 保存済みの住所を使う場合
      if params[:order][:saved_address_id].present?
        selected = Address.find(params[:order][:saved_address_id])
        @selected_address = selected.postal_code + " " + selected.address + " " + selected.name
      else
        render :new  # 保存済み住所が選択されていない場合は新規注文画面に戻す
      end
    when "new_address"  # 新しい住所を使う場合
      @new_postal_code = params[:order][:new_postal_code]
      @new_address = params[:order][:new_address]
      @new_name = params[:order][:new_name]
    else
      render :new 
    end
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
