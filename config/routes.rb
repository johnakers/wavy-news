# frozen_string_literal: true

# routes for WavyNews
Rails.application.routes.draw do
  root 'stories#index'

  resources :stories, only: [:show] do
    resources :comments, only: [:show]
  end
end
