class Movie < ApplicationRecord
  has_many :favorite_movies
  has_many :users, through: :favorite_movies
  has_many :copies
  has_many :rentals, through: :copies

  validates :title, presence: true
  validates :genre
  validates :year, presence: true, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: Time.now.year }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
