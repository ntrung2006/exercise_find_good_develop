Rails.application.routes.draw do
  resources :developers

  root to: 'developers#index'
  
  namespace :api do
    namespace :v1 do
      resources :developers, only: %i[show]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
