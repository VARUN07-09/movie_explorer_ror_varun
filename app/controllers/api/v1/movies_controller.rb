class Api::V1::MoviesController < ApplicationController
  before_action :authenticate_request, only: [:create] 
  before_action :authorize_admin, only: [:create]  
  before_action :find_movie, only: [:show]  

 
  def index
    result = MoviesService.get_all_movies
    if result[:success]
      render json: result[:data], status: :ok
    else
      render json: { error: 'Failed to fetch movies', details: result[:error] }, status: :unprocessable_entity
    end
  end


  def show
    if @movie
      render json: @movie, status: :ok
    else
      render json: { error: 'Movie not found' }, status: :not_found
    end
  end

  def create
    movies_params = params.require(:movies).map do |movie|
      movie.permit(:title, :genre, :release_year, :rating, :language, :origin, :poster_url)
    end

    result = MoviesService.create_movies(movies_params)

    if result[:success]
      render json: { message: 'Movies successfully created', data: result[:data] }, status: :created
    else
      render json: { error: 'Failed to create movies', details: result[:error] }, status: :unprocessable_entity
    end
  end

  private

  
  def find_movie
    @movie = Movie.find_by(id: params[:id])
  end


  def authorize_admin
    unless current_user && current_user.role == "admin"
      render json: { error: 'Only admins can create movies' }, status: :forbidden
    end
  end
end
