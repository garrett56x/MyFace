class TimelineController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @friends = User.find(session[:user_id]).friends
    @invited = Invitation.where(user:session[:user_id])

    # creates array to remove all friends and invited people from all users list
    @subtractor = Array.new
    @subtractor.push(session[:user_id])

    @friends.each do |friend|
      @subtractor.push(friend.id)
    end

    @invited.each do |invitee|
      @subtractor.push(invitee.invitee)
    end

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
