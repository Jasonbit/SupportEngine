Rails.application.routes.draw do

  mount SupportEngine::Engine => "/help"

  root to: "home#index"
end
