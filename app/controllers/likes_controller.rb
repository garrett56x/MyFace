class LikesController < ApplicationController
  def show
    @user = User.find(session[:user_id])
    @requestsCount = Invitation.where(invitee:session[:user_id]).count

    case params[:like_type]
    when 'post'
      @likes = Like.where(post_id: params[:id])
    when 'comment'
      @likes = Like.where(comment_id: params[:id])
    end
  end
  def create
    case params[:like_type]
    when 'post'
      User.find(session[:user_id]).likes.create(post_id:params[:post_id])
      case params[:location]
      when 'timeline'
        redirect_to '/timeline'
      when 'profile'
        redirect_to '/users/' + params[:id]
      end
    when 'comment'
      User.find(session[:user_id]).likes.create(comment_id:params[:comment_id])
      case params[:location]
      when 'timeline'
        redirect_to '/timeline'
      when 'profile'
        redirect_to '/users/' + params[:id]
      end
    end
  end

  def unlike
    case params[:like_type]
    when 'post'
      Like.where(user_id: session[:user_id], post_id:params[:post_id]).first.destroy
      case params[:location]
      when 'timeline'
        redirect_to '/timeline'
      when 'profile'
        redirect_to '/users/' + params[:id]
      end
    when 'comment'
      Like.where(user_id: session[:user_id], comment_id:params[:comment_id]).first.destroy
      case params[:location]
      when 'timeline'
        redirect_to '/timeline'
      when 'profile'
        redirect_to '/users/' + params[:id]
      end
    end
  end
end
