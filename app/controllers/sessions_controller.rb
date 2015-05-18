class SessionsController < ApplicationController
  def create
  	#  references the function we made in user.rb
  	user = User.authenticate(params[:session][:email], params[:session][:password])
	if user.nil?
		flash[:errors] = ['Incorrect login information']
		redirect_to '/users'
	else
		session[:user_id] = user.id
		redirect_to '/timeline'
	end
  end

  def destroy
  	reset_session
  	redirect_to '/users'
  end
end
