Rails.application.routes.draw do

  mount SupportEngine::Engine => "/help"
end
