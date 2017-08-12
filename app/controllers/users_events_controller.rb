class UsersEventsController < ApplicationController
	def create
		user_event = UserEvent.new(user: current_user, event: Event.find(params[:id]))
		if user_event.valid? == true
			user_event.save
			redirect_to '/events'
		else
			flash[:user_event_errors] = "not able to join event"
			redirect_to '/events'
		end
	end

	def destroy
		user_event = UserEvent.where(user: current_user, event: Event.find(params[:id])) 
		user_event.each{ |ue| ue.destroy }
		redirect_to '/events'
	end
end
