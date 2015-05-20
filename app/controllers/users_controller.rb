class UsersController < ApplicationController
  def index
    if flash[:errors]
      @errors = flash[:errors]
    end
    if flash[:success]
      @success = flash[:success]
    end
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created!"
      redirect_to '/users'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/users'
    end
  end

  def show
    @user = User.find(session[:user_id])
    @friend = User.find(params[:id])

    @statuses = Post.where(user: params[:id])
    @messages = Post.where(recipient: params[:id])
    @allPosts = Array.new

    @statuses.each do |status|
      @allPosts.push(status.id)
    end
    @messages.each do |message|
      @allPosts.push(message.id)
    end

    @posts = Post.where(id: @allPosts).order(created_at: :desc)

    @friends = User.find(params[:id]).friends
    @comments = Comment.all
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    User.find(session[:user_id]).update(user_params)
    redirect_to '/timeline'
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :profile_pic)
    end

end
