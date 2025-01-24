Rails.application.routes.draw do
  get "repos/index"
  get "repos/show"
  get "users/index"
  get "users/show"
  get "users/new"
  get "users/edit"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  resources :users
  resources :repos
  resources :repo_data
  

  # namespace :repo_data do
  #       resources :repo_traffic_data_views_biweeklies, only: [ :index ]
  #       resources :repo_traffic_data_views_dailies, only: [ :index ]
  #       resources :repo_traffic_data_clones_biweeklies, only: [ :index ]
  #       resources :repo_traffic_data_clones_dailies, only: [ :index ]
  #       resources :repo_traffic_data_referrers_biweeklies, only: [ :index ]
  #       resources :repo_traffic_data_paths_biweeklies, only: [ :index ]
  # end
end
