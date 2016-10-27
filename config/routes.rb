Rails.application.routes.draw do
  resources :decisions do
    resources :alternatives
    resources :criteria
    member do
      get 'admin'
    end
  end
  get 's/:short_url' => 'decisions#expand_short_url'

  devise_for :users
  root 'decisions#index'
end
