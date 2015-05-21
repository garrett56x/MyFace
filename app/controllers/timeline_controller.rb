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

    # List of which posts to display (user, user's friends)
    @adder = Array.new
    @adder.push(session[:user_id])
    @friends.each do |friend|
      @adder.push(friend.id)
    end

    @posts = Post.where(user: @adder).order(created_at: :desc)
    @friends = User.find(session[:user_id]).friends
    @comments = Comment.all
    @requestsCount = Invitation.where(invitee:session[:user_id]).count
  end
end
