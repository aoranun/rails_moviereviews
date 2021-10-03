Rails.application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/movie/:id', to: 'movies#show', as: 'movie_show'
  # Route that posts 'Search TMDb' form
  post '/movies/search_tmdb'

end
