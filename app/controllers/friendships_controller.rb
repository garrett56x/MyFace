class FriendshipsController < ApplicationController
  def index
  end

  def new
  end

  def create
    User.find(session[:user_id]).friendships.create(friend_id:params[:invitor])
    User.find(params[:invitor]).friendships.create(friend_id:session[:user_id])
    Invitation.find(params[:invitation_id]).destroy
    redirect_to '/requests'
  end

  def show
  end

  def update
  end

  def edit
  end

  def destroy
  end
end
