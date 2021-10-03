# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    # @movies = Movie.all
    #@movies = Movie.order('title ASC')
    #@movies = Movie.order(params[:sort]).all
    #url = "https://api.themoviedb.org/3/movie?api_key=#{ Rails.application.credentials[:tmdb][:access_key_id] }"
    url = "https://api.themoviedb.org/3/trending/all/day?api_key=#{ Rails.application.credentials[:tmdb][:access_key_id] }"

    @movies = JSON.parse(Net::HTTP.get(URI(url)))
    logger.debug @movies
  end

  def show
    #id = params[:id] # retrieve movie ID from URI route
    #@movie = Movie.find(id)
    # will render app/views/movies/show.html.haml by default
    begin
      id = params[:id]
      @movie = Movie.find(id) # look up movie by unique ID
    rescue ActiveRecord::RecordNotFound
      redirect_to movies_path
      flash[:notice] = "Sorry, we don't have a movie ID #{id}"
      #render app/views/movies/movie_notfound.html.erb
    end
  end

  def new
    # default: render 'new' template
  end

#  def create
#    @movies = Movie.create!(params[:movie])
#    flash[:notice] = "#{@movie.title} was successfully created."
#    redirect_to movies_path
#  end
  def edit
    @movie = Movie.find params[:id]

  end

  def update
    @movie = Movie.find params[:id]
    @movie.update(movie_params)
    #respond_to do |client_wants|
    #  client_wants.html {  redirect_to movie_path(@movie)  } # as before
    #  client_wants.xml  {  render :xml => @movie.to_xml    }
    #end

    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def create
    @movie = Movie.create(movie_params)
    # ...
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to @movie
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  private
  def search_api(query, page=1)
    url = "https://api.themoviedb.org/3/search/movie?api_key=#{ Rails.application.secrets.tmdb_api_key }&query=#{ query }&page=#{ page }"
    data = JSON.parse(Net::HTTP.get(URI(url)))
  end

end
