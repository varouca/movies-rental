class RentalsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    copy = Copy.available.where(movie_id: params[:id], media: params[:media]).first
    
    if copy
      rental = Rental.create(user_id: user.id, copy_id: copy.id)
      render json: rental    
    else
      render json: { error: "Sorry, no copies available at the moment" }, status: 404
    end
  end

  def history_by_user
    @rentals = User.find(params[:user_id]).rentals.includes(:copy)
    render json: @rentals.as_json(include: { copy: { only: [:id, :media] } }, except: [:created_at, :updated_at, :copy_id])
  end
  
  def active_by_user
    @rentals = User.find(params[:user_id]).rentals.active.includes(:copy)
    render json: @rentals.as_json(include: { copy: { only: [:id, :media] } }, except: [:created_at, :updated_at, :copy_id])
  end
end