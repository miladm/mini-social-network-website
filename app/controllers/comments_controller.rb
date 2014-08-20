class CommentsController < ApplicationController
	def index()
		@comment_list 	= Comment.find_by_photo_id(params[:photo_id])
		@new_comment 	= params[:note]
	end

	def show()
	end

	def new()
		@photo 		= Photo.find(params[:photo_id])
		@post_to 	= ["/photos/", @photo.id, "/comments"].join('')
	end

	def create()
		# GET PARAMTERS
		@text 		= params[:comment][:text]
		@user 		= session[:user_session]
		@photo 		= Photo.find(params[:photo_id])
		@date_time	= Time.current
		@url		= params[:url]

		if not @text.empty? then
			# MAKE PHOTO OBJECT
			@comment 		= Comment.new(:date_time => @date_time, :comment => @text)
	    	@comment.user 	= @user
	    	@comment.photo 	= @photo

	    	# REDICRECT
	    	if not @comment.save(:validate => true) then
				flash.notice = "Oops... something went wrong! Write your comment again."
				redirect_to :action => "new"
	    	else
				flash.notice = "You wrote: "
				redirect_to :action => @url, :note => @text
	    	end
		else
			# REDICRECT
			flash.notice = "Oops... you posted an empty message! Write something, don't be shy :)"
			redirect_to :action => "new"
		end
	end
end