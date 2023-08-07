class RentalService
    def self.create_rental(user_id, movie_id, media)
      user = User.find(user_id)
      copy = Copy.available.where(movie_id: movie_id, media: media).first
  
      if copy
        rental = Rental.create(
          user_id: user.id,
          copy_id: copy.id,
          checkout_date: Date.today,
          due_date: Date.today + 7.days
        )
        return rental
      else
        return nil
      end
    end
  
    def self.return_rental(rental_id)
      rental = Rental.find(rental_id)
      rental.returned_date = Date.today
      rental.save
  
      if rental.returned_date > rental.due_date
        message = "Rental returned successfully and is overdue."
      else
        message = "Rental returned successfully."
      end
  
      response_data = {
        'message': message,
        'rental': rental.as_json(except: [:created_at, :updated_at])
      }
      return response_data
    end
  end