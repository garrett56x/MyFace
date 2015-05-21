class PostsController < ApplicationController
  def create
    User.find(session[:user_id]).posts.create(content:params[:status], recipient:params[:recipient])
    
    case params[:location]
    when 'timeline'
      redirect_to '/timeline'
    when 'profile'
      redirect_to '/users/' + params[:id]
    end
  end
  def destroy
  end
end
