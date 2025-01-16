class Admin::GenreController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
  end

  def edit
    @genre = Genre.find[:id]
  end

  def update
  end

end
