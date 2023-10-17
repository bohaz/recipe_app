Rails.application.routes.draw do
  devise_for :users
  resources :foods
  delete 'foods/:id', to: 'foods#destroy', as: 'delete_food'
  root "users#index"
end
