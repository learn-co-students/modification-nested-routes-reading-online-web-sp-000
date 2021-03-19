class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def index
    @authors = Author.all
  end

  def new
    @post = Post.new(author_id: params[:author_id])
  end

end
