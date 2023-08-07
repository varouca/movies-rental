class Copy < ApplicationRecord
  scope :available, -> { where.not(id: Rental.where(returned_date: nil).select(:copy_id)) }   
  
  enum :media, [ :dvd, :bluray, :vhs, :other ]

  has_many :rentals
  belongs_to :movie

  validates :identification_code, presence: true, uniqueness: true
end