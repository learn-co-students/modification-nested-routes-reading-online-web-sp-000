Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end
  resources :posts
end

# creating a new post for an author
# create a new post that is linked to an author
# before: nested resources to view posts by an author
# now: nested resources to create posts by author by adding :new

# access to /authors/:author_id/posts/new, and a new_author_post_path helper

# rake routes:
# url pattern: /authors/:author_id/posts/new = posts#new controller action

#editing an authors posts
#:edit action in the nested route 
