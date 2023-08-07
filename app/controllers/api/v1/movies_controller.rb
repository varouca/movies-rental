class Api::V1::MoviesController < ApplicationController
  def index
    movies = Movie.all.paginate(page: params[:page], per_page: 10)
    render json: movies, except: [:created_at, :updated_at]
  end

  def search
    @movies = Movie.where("title LIKE ?", "%#{params[:q]}%").paginate(page: params[:page], per_page: 10)
    render json: @movies, except: [:created_at, :updated_at]
  end

  def availability
    movie_id = params[:id]
    @copies = Copy.includes(:rentals).where(movie_id: movie_id)
                    
    render json: @copies.as_json(include: { rentals: { only: [:due_date] } }, except: [:id, :created_at, :updated_at])
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.recommendations(favorite_movies)
    render json: @recommendations, except: [:created_at, :updated_at]
  end
end
