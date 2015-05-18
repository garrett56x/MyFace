class TimelineController < ApplicationController
  def index
    @user = User.find(session[:user_id])

    # creates array to remove all friends and invited people from all users list
    @subtractor = Array.new
    @subtractor.push(session[:user_id])

    @users = User.where('id not in (?)', @subtractor)

    @posts = Post.all.reverse
  end

  def new
  end

  def create
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
