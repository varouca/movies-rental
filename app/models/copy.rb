class Copy < ApplicationRecord
  enum :media, [ :dvd, :bluray, :vhs, :other ]
    
  scope :available, -> { where.not(id: Rental.where(returned_date: nil).select(:copy_id)) }

  has_many :rentals
  belongs_to :movie
end