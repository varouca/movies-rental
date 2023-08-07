class AddDatesToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :checkout_date, :date, null: false, after: :user_id
    add_column :rentals, :due_date, :date, null: false, after: :checkout_date
    add_column :rentals, :returned_date, :date, after: :due_date

    remove_index :rentals, column: [:user_id, :movie_id]
    add_index :rentals, [:user_id, :movie_id]
  end
end
