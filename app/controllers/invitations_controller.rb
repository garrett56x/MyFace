class InvitationsController < ApplicationController
  def create
    User.find(session[:user_id]).invitations.create(invitee:params[:invitee])
    redirect_to '/timeline'
  end
  
  def requests
    @user = User.find(session[:user_id])
    @requests = Invitation.where(invitee:session[:user_id])
    @requestsCount = Invitation.where(invitee:session[:user_id]).count
  end

  def destroy
    Invitation.find(params[:id]).destroy
    redirect_to '/requests'
  end
end
