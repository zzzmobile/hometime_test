Rails.application.routes.draw do
  resource :reservations, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
