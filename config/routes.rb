Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users
      resources :events
      resources :calendars
      resources :constellations
      resources :sky_events 
      #double check these:
      post '/login', to: 'auth#create'
      get '/current_user', to: 'auth#show'
      get '/profile', to: 'users#profile'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
