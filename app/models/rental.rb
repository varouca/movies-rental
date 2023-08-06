class Rental < ApplicationRecord   
    belongs_to :user
    belongs_to :movie

    validates :checkout_date, presence: true
    validates :due_date, presence: true
end