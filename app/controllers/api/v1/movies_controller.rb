
class Api::V1::MoviesController < ApplicationController
  def index
    @movies = Movie.all
                    .includes(:copies)
                    .paginate(page: params[:page], per_page: 10)
    render json: @movies, except: [:created_at, :updated_at]
  end

  def search
    @movies = Movie.where("title LIKE ?", "%#{params[:q]}%")
                    .includes(:copies)
                    .paginate(page: params[:page], per_page: 10)
    render json: @movies.as_json(include: { copy: { only: [:id, :media] } }, except: [:created_at, :updated_at])
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations, except: [:created_at, :updated_at]
  end
end
