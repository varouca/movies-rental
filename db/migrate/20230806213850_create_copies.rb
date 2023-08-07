class CreateCopies < ActiveRecord::Migration[7.0]
  def change
    create_table :copies do |t|
      t.references :movie, null: false, foreign_key: true
      t.string :identification_code, null: false
      t.integer :media, null: false, default: 0
      
      t.timestamps
    end
  end
end
