class Movie < ApplicationRecord
  has_many :favorite_movies
  has_many :users, through: :favorite_movies
  has_many :copies
  has_many :rentals, through: :copies
end
  