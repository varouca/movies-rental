class Rental < ApplicationRecord
    scope :active, -> { where(returned_date: nil) }
    scope :overdue, -> { where("due_date < ?", Date.today) }

    belongs_to :copy
    belongs_to :user

    validates :checkout_date, presence: true
    validates :due_date, presence: true
end