Rails.application.routes.draw do
  devise_for :users
  resources :foods
  resources :recipes, except: [:update]
  delete 'foods/:id', to: 'foods#destroy', as: 'delete_food'
      root "users#index"
  get 'public_recipes', to: 'public_recipes#index'
end
