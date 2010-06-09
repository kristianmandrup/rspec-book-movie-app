class MoviesController < ApplicationController
  def index
  end

  def new
    @movie = Movie.new
    @genres = Genre.all
  end
  
  def create
    movie = Movie.create!(params[:movie])
    genres = Genre.find(params[:genres])
    movie.genres = genres
    movie.save!
    redirect_to movies_path
  end
end
