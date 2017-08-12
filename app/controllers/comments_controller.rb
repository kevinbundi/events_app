class CommentsController < ApplicationController
	def create
		comment = Comment.create(content: params[:content], user: current_user, event: Event.find(params[:id]))
		if comment.valid? == true
			comment.save
			redirect_to '/events/' + params[:id].to_s 
		else
			flash[:comment_errors] = comment.error.full_messages
			redirect_to '/events/' + params[:id].to_s 
		end
	end

	def destroy
		comment = Comment.find(params[:id]).destroy
		redirect_to '/events/' + session[:event_id].to_s
	end
end
