Rails.application.routes.draw do
  resources :memberships, except: [:index, :show]
  resources :alternatives, except: [:index, :show]
  resources :criteria, except: [:index, :show]
  resources :decisions, except: [:index] do
    member do
      get 'admin'
    end
  end
  get 's/:short_url' => 'decisions#expand_short_url'

  devise_for :users
  root 'decisions#index'
end
