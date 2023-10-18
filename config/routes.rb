Rails.application.routes.draw do
  devise_for :users
  resources :foods
  
  resources :recipes, except: [:update] do
    member do
      patch :toggle_public
    end
    resources :recipe_foods, only: [:new, :create]
  end
  
  resources :recipe_foods, except: [:new, :create, :update]

  delete 'foods/:id', to: 'foods#destroy', as: 'delete_food'
  root "users#index"
end
