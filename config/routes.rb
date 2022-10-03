Rails.application.routes.draw do
  root 'stories#index'

  resources :stories, only: [:show] do
    resources :comments, only: [:index, :show]
  end
end
