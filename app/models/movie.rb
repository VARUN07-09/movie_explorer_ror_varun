class Movie < ApplicationRecord
    has_one_attached :poster
    validates :title, presence: true
    validates :genre, inclusion: { in: %w[Action Comedy Drama Horror Sci-Fi Romance Thriller] }, allow_blank: true
    validates :release_year, numericality: { only_integer: true, greater_than: 1880, less_than_or_equal_to: -> { Date.current.year } }, allow_blank: true
    validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, allow_blank: true
    validates :poster, content_type: ['image/png', 'image/jpeg'], size: { less_than: 5.megabytes }
  end