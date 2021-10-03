class Movie
  # attr_accessible :title, :rating, :description, :release_date
  def movies_TMDb
    url = "https://api.themoviedb.org/3/movie/550?api_key=04f24aef232a3dab5da1fc4f43567353"
    data = JSON.parse(open(url).read)
  end

end
