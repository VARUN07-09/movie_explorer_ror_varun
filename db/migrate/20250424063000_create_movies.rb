class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :genre
      t.integer :release_year
      t.decimal :rating, precision: 3, scale: 1

      t.timestamps
    end
  end
end