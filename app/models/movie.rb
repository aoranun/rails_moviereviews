class Movie < ActiveRecord::Base
  # attr_accessible :title, :rating, :description, :release_date
  def create
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
