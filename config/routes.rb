# frozen_string_literal: true

Rails.application.routes.draw do
  resources :zipcodes, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /health that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "health" => "rails/health#show", as: :rails_health_check


  # Defines the root path route ("/")
  root "zipcodes#index"
end
