class PhotosController < ApplicationController
	def index()
		@photo_list = Photo.find(:all)
	end

	def show()
		@photo = Photo.find(params[:id])
	end

	def new()
		@post_to 	= "/photos"
	end

	def create()
		if params[:new_photo] != nil then
			# CREATE IMAGE ATTRIBUTES
			@file_name	= params[:new_photo][:photo].original_filename
			@file 		= params[:new_photo][:photo].read
			@user 		= session[:user_session]
			@date_time	= Time.current

			# STORE IMAGE INFO IN DB
			@new_photo = Photo.new(:date_time => @date_time, :file_name => @file_name)
			@new_photo.user = @user
			if not @new_photo.save(:validate => true) then
				# REDIRECT
				flash.notice = "No image was uploaded. Please try again."
				redirect_to :action => 'new'
			else
				# WRITE IMAGE TO IMAGES DIR
				@directory	= "app/assets/images"
				@path 		= File.join(@directory, @file_name)
				File.open(@path, 'wb') do |f|
					f.write(@file)
				end

				# REDIRECT
				flash.notice = "Your image is uploaded."
				redirect_to :action => 'index'
			end
			
		else
			# REDIRECT
			flash.notice = "No image was uploaded. Please try again."
			redirect_to :action => 'new'
		end
	end

	# def upload(file)

	# end
end