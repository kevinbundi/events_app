class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  def render_404
    render :template => "errors/error_404", :status => 404 
  end
  # def not_found
  #   raise ActionController::RoutingError.new('Not Found')
  # end

   # render 404 error page if route not found
  # unless Rails.application.config.consider_all_requests_local
  #   rescue_from ActionController::RoutingError, with: -> { render_404 }
  # end

  # def render_404
  #   respond_to do |format|
  #     format.html { render template: 'errors/not_found', status: 404 }
  #     format.all { render nothing: true, status: 404 }
  #   end
  # end
  
  private
  def require_login
  	redirect_to '/' if !session[:user_id]
  end
  def logged_in
  	redirect_to '/events' if current_user
  end
end
