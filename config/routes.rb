Rails.application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html  get '/movie/new_tmdb', to: 'movies#new_tmdb', as: 'new_tmdb'
  post '/movie/new_tmdb', to: 'movies#new_tmdb', as: 'new_tmdb'
  get '/movie/:id', to: 'movies#show_tmdb', as: 'movie_show'
  # Route that posts 'Search TMDb' form
  post '/movies/search_tmdb'


end
