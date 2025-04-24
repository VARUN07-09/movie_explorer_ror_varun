class AddLanguageAndOriginToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :language, :string
    add_column :movies, :origin, :string
  end
end
