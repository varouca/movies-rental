class RemoveCopiesFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :available_copies
  end
end
