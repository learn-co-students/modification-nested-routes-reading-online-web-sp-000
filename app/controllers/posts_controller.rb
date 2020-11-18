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

  def new

    if params[:author_id] && !Author.exists?(params[:author_id])

        redirect_to authors_path, alert: "Author not found."

    else #valid author id OR no author id in params
        @post = Post.new(author_id: params[:author_id])
    #author id is a method that's smart enough to find the author and associate
    #i guess if the params doesnt happen it still wont cause an error
    #warning: this is not enough to make it save. and u must relay this info into the form in a hidden tag
    #all u gotta do is:   <%= f.hidden_field :author_id %>
    #if theres no author id, it will be saved as empty
    

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

  def edit
    if params[:author_id] #if nested
      
      author = Author.find_by(id: params[:author_id])
      if author.nil? #invalid author id
        redirect_to authors_path, alert: "Author not found."

      else #valid author id
        @post = author.posts.find(params[:id])
        redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
      end

    else
      @post = Post.find(params[:id])
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
