Rails.application.routes.draw do
  resources :authors do
    resources :posts, only: [:index,:show,:new,:edit]
  end

  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
