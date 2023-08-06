class ChangeRentalReference < ActiveRecord::Migration[7.0]
  def change
    remove_index :rentals, column: [:user_id, :movie_id]
    remove_column :rentals, :movie_id
    add_reference :rentals, :copy, foreign_key: true, after: :user_id

    add_index :rentals, [:user_id, :copy_id]
  end
end
