Rails.application.routes.draw do 
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :companies
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "companies#static"

  get "/auth/google_oauth2/callback", to: "sessions#create"

end
