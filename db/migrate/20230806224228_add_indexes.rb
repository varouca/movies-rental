class AddIndexes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :name, false
    add_index :users, :name

    add_column :movies, :year, :integer, null: false, after: :title
    add_index :movies, [:title, :year], unique: true
    change_column_null :movies, :genre, false
  end
end
