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
    else
      @post = Post.new(author_id: params[:author_id])
      # passing the params[:author_id] into Post.new()
      # we want to make sure that if we capture an author_id through a nested route
      # we keep track of it and assign the post to that author.
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

  def edit    # /authors/1/posts/1/edit
    if params[:author_id]
      # Here we're looking for the existence of params[:author_id] that comes from nested route
      author = Author.find_by(id: params[:author_id])
      if author.nil?
        redirect_to authors_path, alert: "Author not found."
        # If params[:author_id] is there, we make sure to find a valid author by checking if author.nil? If we can't, we redirect them to the authors_path with a flash[:alert]
      else
        @post = author.posts.find_by(id: params[:id])
        # If we do find the author (author isn't nil), we next want to find the post by params[:id]
        # Instead of directly looking for Post.find(), we need to filter the query through our author.posts collection to make sure we find it in that author's posts. 
        # ***** find method doesn't show nil, find_by does. *****
        redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
          # It may be a valid post id, but it might not belong to that author, which makes this an invalid request, so we need to check!!!
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
