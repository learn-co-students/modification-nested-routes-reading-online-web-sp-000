class PostsController < ApplicationController

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
  end

#We have the route, now update new action to handle the :author_id param
#if we capture author_id through a nested route, we keep track of it
# and assign the post to that author
def new
  if params[:author_id] && !Author.exists?(params[:author_id]) #check for params[:author_id] and see if author exists 
    redirect_to authors_path, alert: "Author not found."
  else
    @post = Post.new(author_id: params[:author_id]) #creating a new post for a valid author
  end
end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
  @post = Post.find(params[:id])
  @post.update(post_params)
  redirect_to post_path(@post)
end

#check if author_id is valid and the post matches the author
def edit
if params[:author_id] #comes from our nested route
  author = Author.find_by(id: params[:author_id]) #find valid author
  if author.nil?
    redirect_to authors_path, alert: "Author not found." #flash alert if can't find valid author
  else
    @post = author.posts.find_by(id: params[:id]) #if author valid, find post by params[:id], query through our author.posts
    redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
  end
else
  @post = Post.find(params[:id])
end
end

  private

#strong params
#post controller must accept :author_id as a param for a post
#strong params = security practice to help prevent allowing users to update sensitive model attributes
# author_id allowed for mass assignment in the create action
  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
