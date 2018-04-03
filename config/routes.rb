Rails.application.routes.draw do
  resources :developers
  post :search, to: 'developers#search'

  root to: 'developers#index'
end
