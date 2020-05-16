Rails.application.routes.draw do
  resources :authors
  namespace :api, defaults: {format: 'json'} do
    resources :authors
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
