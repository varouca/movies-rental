class Api::V1::RentalsController < ApplicationController
  def rent
    rental = RentalService.create_rental(params[:user_id], params[:movie_id], params[:media])

    if rental
      render json: rental
    else
      render json: { error: "Sorry, no copies available at the moment" }, status: 404
    end
  end

  # "Return" is the correct name for this concept, but it's a reserved word in Ruby
  def bring_back
    response_data = RentalService.return_rental(params[:id])
    render json: response_data
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