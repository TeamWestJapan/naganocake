class SearchesController < ApplicationController
  def search
    @word = params[:word]
    @items = Item.search_for(@word)
  end
end


