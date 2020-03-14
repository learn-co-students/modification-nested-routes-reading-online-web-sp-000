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

  def new #to ensure that we're creating a new post for a valid author
    if params[:author_id] && !Author.exists?(params[:author_id])#Here we check for params[:author_id] and then for Author.exists? to see if the author is real.
      redirect_to authors_path, alert: "Author not found."
    else
      @post = Post.new(author_id: params[:author_id])#if we capture an author_id through a nested route, we keep track of it and assign the post to that author.
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
    #check to make sure that 1) the author_id is valid and 2) the post matches the author
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      if author.nil?#we want to make sure that we find a valid author. If we can't, we redirect them to the authors_path with a flash[:alert].
        redirect_to authors_path, alert: "Author not found."
      else#If we do find the author, we next want to find the post by params[:id], but, instead of directly looking for Post.find()
        #, we need to filter the query through our author.posts collection to make sure we find it in that author's posts.
        # It may be a valid post id, but it might not belong to that author, which makes this an invalid request.
        @post =author.posts.find_by(id: params[:id])
        redirect_to author_posts_path(author), alert: "Post not found" if @post.nil?
      end
    else
      @post = Post.find_by(params[:id])
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)# author_id will be allowed for mass-assignment in the create action.
  end
end
