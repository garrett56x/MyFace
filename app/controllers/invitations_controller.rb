class InvitationsController < ApplicationController
  def index
  end

  def new
  end

  def create
    User.find(session[:user_id]).invitations.create(invitee:params[:invitee])
    redirect_to '/timeline'
  end

  def update
  end

  def edit
  end

  def show
  end

  def requests
    @user = User.find(session[:user_id])
    @requests = Invitation.where(invitee:session[:user_id])
  end

  def destroy
    Invitation.find(params[:id]).destroy
    redirect_to '/requests'
  end
end
