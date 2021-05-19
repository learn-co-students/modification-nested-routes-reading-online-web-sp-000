Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end
  resources :posts
end

# Prefix Verb   URI Pattern                                  Controller#Action
#     author_posts GET    /authors/:author_id/posts(.:format)          posts#index
#  new_author_post GET    /authors/:author_id/posts/new(.:format)      posts#new
# edit_author_post GET    /authors/:author_id/posts/:id/edit(.:format) posts#edit
#      author_post GET    /authors/:author_id/posts/:id(.:format)      posts#show
#          authors GET    /authors(.:format)                           authors#index
#           author GET    /authors/:id(.:format)                       authors#show
#            posts GET    /posts(.:format)                             posts#index
#                  POST   /posts(.:format)                             posts#create
#         new_post GET    /posts/new(.:format)                         posts#new
#        edit_post GET    /posts/:id/edit(.:format)                    posts#edit
#             post GET    /posts/:id(.:format)                         posts#show
#                  PATCH  /posts/:id(.:format)                         posts#update
#                  PUT    /posts/:id(.:format)                         posts#update
#                  DELETE /posts/:id(.:format)                         posts#destroy
