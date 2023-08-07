class UsersController < ApplicationController
  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations, except: [:created_at, :updated_at]
  end
end