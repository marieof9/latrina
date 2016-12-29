require 'routing_helper'

Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  resources :latrinas, path: '/', only: [:index, :show]
  lock ':id', to: 'latrinas#lock'
  unlock ':id', to: 'latrinas#unlock'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
