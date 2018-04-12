Rails.application.routes.draw do
  resources :developers

  root to: 'developers#index'
end
