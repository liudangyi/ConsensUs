Rails.application.routes.draw do
  resources :decisions
  devise_for :users
  root 'decisions#index'
end
