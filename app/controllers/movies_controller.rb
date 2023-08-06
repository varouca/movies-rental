class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies, except: [:created_at, :updated_at]
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations, except: [:created_at, :updated_at]
  end

  def user_rented_movies
    @rented = User.find(params[:user_id]).rented
    render json: @rented
  end

  def rent
    user = User.find(params[:user_id])
    movie = Movie.find(params[:id])
    movie.available_copies -= 1
    movie.save
    user.rented << movie
    render json: movie
  end

end