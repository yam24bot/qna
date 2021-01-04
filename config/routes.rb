Rails.application.routes.draw do
  # root to: 'questions#index'
  root 'static#index'

  namespace :v1, defaults: { format: 'json' } do
    devise_for :users

    resources :questions

    get 'questions', to: 'question:index'
  end
end
