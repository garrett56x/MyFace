class PostsController < ApplicationController
  def index
  end

  def new
  end

  def create
    User.find(session[:user_id]).posts.create(content:params[:status], recipient:params[:recipient])
    
    case params[:location]
    when 'timeline'
      redirect_to '/timeline'
    when 'profile'
      redirect_to '/users/' + params[:id]
    end
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
