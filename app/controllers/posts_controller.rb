class PostsController < ApplicationController
  def index
  end

  def new
  end

  def create
    User.find(session[:user_id]).posts.create(content:params[:status])
    redirect_to '/timeline'
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
