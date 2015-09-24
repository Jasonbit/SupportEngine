SupportEngine::Engine.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :tickets
    end
  end

  resources :tickets
  resources :comments
  resource :support_types

  root to: "tickets#index"
end
