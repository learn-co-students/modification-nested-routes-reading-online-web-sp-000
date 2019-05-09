Rails.application.routes.draw do
  resources :authors, only: [:index, :show] do
    resources :posts, only: [:show, :index, :new, :edit]
  end
end
