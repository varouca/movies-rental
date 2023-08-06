class Copy < ApplicationRecord
    enum :media, [ :dvd, :bluray, :vhs, :other ]

    belongs_to :movie
end
