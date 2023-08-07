class Api::V1::RentalsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    copy = Copy.available.where(movie_id: params[:movie_id], media: params[:media]).first
        
    if copy
      @rental = Rental.create(
        user_id: user.id,
        copy_id: copy.id,
        checkout_date: Date.today,
        due_date: Date.today + 7.days
      )

      render json: @rental    
    else
      render json: { error: "Sorry, no copies available at the moment" }, status: 404
    end
  end

  # "Return" is the correct name for this concept, but it's a reserved word in Ruby
  def bring_back
    @rental = Rental.find(params[:id])
    @rental.returned_date = Date.today
    @rental.save

    if @rental.returned_date > @rental.due_date
      message = "Rental returned successfully and is overdue."
    else
      message = "Rental returned successfully."
    end

    response_data = {
      'message': message,
      'rental': @rental.as_json(except: [:created_at, :updated_at])
    }

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