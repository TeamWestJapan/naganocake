class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to request.referer
    else
      render :index
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  def edit
  end

  

  def update
  end

  

  private

  def address_params
    params.require(:addresses).permit(:postal_code, :address, :name)
  end
end
