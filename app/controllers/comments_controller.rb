class CommentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    User.find(session[:user_id]).comments.create(post_id:params[:post_id], comment:params[:comment])
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
