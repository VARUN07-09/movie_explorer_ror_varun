class MoviesService
  
  def self.get_all_movies
    begin
      
      movies = Movie.all
      if movies.any?
        { success: true, data: movies }
      else
        { success: false, error: 'No movies found' }
      end
    rescue StandardError => e
      { success: false, error: e.message }
    end
  end

  
  def self.create_movies(movies_params)
    begin
      
      ActiveRecord::Base.transaction do
        
        movies = movies_params.map do |movie_param|
          Movie.create!(movie_param)  
        end
        
        { success: true, data: movies }
      end
    rescue ActiveRecord::RecordInvalid => e
      
      { success: false, error: e.record.errors.full_messages.join(", ") }
    rescue StandardError => e
     
      { success: false, error: e.message }
    end
  end

  
  def self.get_movie_by_id(id)
    begin
      
      movie = Movie.find_by(id: id)
      if movie
        { success: true, data: movie }
      else
        { success: false, error: 'Movie not found' }
      end
    rescue StandardError => e
      
      { success: false, error: e.message }
    end
  end
end
