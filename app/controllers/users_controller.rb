class UsersController < ApplicationController
  before_action :logged_in, only:  [:new]

  def create
  	user = User.new(user_params)
  	if user.valid? == true
  		user.save
  		flash[:register_message] = "Registration Successful"
  		redirect_to '/'
  	else
  		flash[:register_errors] = user.errors.full_messages
  		redirect_to '/users/new'
  	end
  end
  
  def new
  end

  def show
    @user = User.find(params[:id])
    @events_created = current_user.events
    @events_attending = current_user.events_attendings
  end

  def edit
  end

  def update
    user = User.update params[:id], update_params
    if user.save
      redirect_to '/users/' + params[:id]
    else
      flash[:update_errors] = user.errors.full_messages
      redirect_to '/users/' + params[:id].to_s + '/edit'
    end
  end

  private
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation) 
  end
  def update_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :state)
  end
end
