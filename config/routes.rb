Rails.application.routes.draw do
  devise_for :users
  resources :foods
  
  resources :recipes, except: [:update] do
    member do
      patch :toggle_public
    end
    resources :recipe_foods, only: [:new, :create]
  end
  
  resources :recipe_foods, except: [:new, :create]

  delete 'foods/:id', to: 'foods#destroy', as: 'delete_food'
  get 'public_recipes', to: 'public_recipes#index'
  get 'shopping_list', to: 'shopping_lists#index'
  root "users#index"
end
