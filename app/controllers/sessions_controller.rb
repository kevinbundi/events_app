class SessionsController < ApplicationController
	skip_before_action :require_login, except: [:destroy]
	before_action :logged_in, only: [:new]

  def new 
  end
  def create
  	user = User.find_by_email(params[:email])
  	if params[:email] == ""
  		 flash[:login_error] = "email cant be blank"
  	redirect_to '/'
  	elsif params[:password] == ""
	    flash[:login_error] = "password cant be blank"
	    redirect_to '/'
    elsif !user
        flash[:login_error] = "email address not found"
        redirect_to '/' 
    elsif !user.authenticate(params[:password])
        flash[:login_error] = "wrong password"
        redirect_to '/' 
    else
    	session[:user_id] = user.id
    	redirect_to '/events'
    end
  end
  def destroy
  	session[:user_id] = nil
  	redirect_to '/' 
  end
end
