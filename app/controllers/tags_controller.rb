class TagsController < ApplicationController

	def index()
	end

	def new()
	end

	def create()
		@pic_id = ["pic", params[:photo_id]].join('')
		if params[@pic_id] != nil && session[:user_session] != nil then
			@top 	= params[@pic_id][:tagTop]
			@left 	= params[@pic_id][:tagLeft]
			@height = params[@pic_id][:tagHeight]
			@width	= params[@pic_id][:tagWidth]
			@user	= params[@pic_id][:id]
			@date_time	= Time.current
			@photo 		= Photo.find(params[:photo_id])
			@user_name	= User.find(@user).full_name
			@url		= params[:url]

			@tag_new = Tag.new(:photo_id => @photo.id, :user_id => @user, :top => @top, :left => @left, :width => @width, :height => @height, :date_time => @date_time)
	    	if not @tag_new.save(:validate => true) then
				flash.notice = "Oops... something went wrong! Try adding your tag again."
				redirect_to :action => "new"
	    	else
				flash.notice = ["You tagged: ", @user_name].join('')
				redirect_to :action => "new"
	    	end
	    else
    		flash.notice = "You are not logged in. Please log-in to your account to tag picture of users."
			redirect_to :action => "new"
		end
	end

	def update()		
	end

end
