class Movie < ApplicationRecord
    has_one_attached :poster
    validates :title, :genre, :release_year, :rating, :language, :origin, :poster_url, presence: true
    validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
    validates :language, presence: true, length: { maximum: 50 }
    validates :origin, presence: true, length: { maximum: 100 }
  end