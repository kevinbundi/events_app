class EventsController < ApplicationController
  before_action :require_login

  def index
  	@events = Event.all.reverse
  	@eventsAttending = UserEvent.all.reverse
  end

  def new
  end

  def create
  	event = current_user.events.new(event_params)
  	if event.valid? == true
  		event.save
      ## join event creater to event by default
      # UserEvent.create(user: current_user, event: Event.find(event.id)) 
      redirect_to '/events'
  	else
  		flash[:register_errors] = event.errors.full_messages 
  		redirect_to '/events'
  	end
  end

  def show
  	@event = Event.find(params[:id])
    session[:event_id] = params[:id]
  	@user_attendings = Event.find(params[:id]).events_attendees
    @event_id = params[:id]
    @comments = Event.find(params[:id]).comments.reverse
  end

  def edit
  	@event = Event.find(params[:id])
  end
  def update
  	event = Event.update params[:id], update_params
  	if event.save
  		redirect_to '/events'
  	else
  		flash[:update_errors] = event.errors.full_messages
  		redirect_to '/events/' + params[:id].to_s + '/edit'
  	end
  end
  def destroy
    Event.find(params[:id]).destroy
    redirect_to '/events'
  end

  private
  def event_params
  	params.require(:event).permit(:host, :name, :date, :location, :state)
  end
  def update_params
  	params.require(:event).permit(:host, :name, :date, :location, :state)
  end
end
