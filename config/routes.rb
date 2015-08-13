SupportEngine::Engine.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :tickets
    end
  end
end
