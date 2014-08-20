class UsersController < ApplicationController
	def index()
		@page_name = "Search"
		@page_msg = "CS 142, Project 7"
		@user_list = User.find(:all)
	end

	def show()
		@page_name = "CS 142 - Project 7"
		@page_msg = "User Records Page"
		@user_elem = User.find(params[:id])
		@users_option = User.find(:all)
		# @tagName = params[:tagForm][:usersList]
		@tag = User.new
	end

	def new()
		@post_to = "/users"
	end

	def create()
		if params[:new_user] != nil then
			@first_name = params[:new_user][:first_name]
			@last_name 	= params[:new_user][:last_name]
			@login 		= params[:new_user][:login]
			@password1	= params[:new_user][:password1]
			@password2	= params[:new_user][:password2]

			@user_login = User.find_by_login(@login)
			if @password1 != @password2 then
				# REDIRECT
				flash.notice = "Your passowrds do not match. Please try again."
				redirect_to :action => 'new'
			elsif @user_login != nil
				flash.notice = @login + " is already taken. Please try a different username."
				redirect_to :action => 'new'
			else
				# STORE USER INFO IN DB
				@new_user = User.new(:first_name => @first_name, :last_name => @last_name, :login => @login)
				@new_user.password = @password1
				if not @new_user.save(:validate => true) then
					flash.notice = "Regisration form was incomplete. Please try again."
					redirect_to :action => 'new'
				else
					# REDIRECT
					flash.notice = "Congratulations! Your account has been created."
					redirect_to :action => 'index'
				end
			end
		else
			# REDIRECT
			flash.notice = "Regisration form was incomplete. Please try again."
			redirect_to :action => 'new'
		end
	end

	def login()
		@page_name = "Login"
		@note = params[:note]
	end

	protect_from_forgery
	def post_login()
		@username = params[:user][:login]
		@password = params[:user][:password]
		@user_login = User.find_by_login(@username)

		# REDIRECT TO APPROPRIATE URL
		if @user_login == nil or not @user_login.password_valid?(@password) then
			flash.notice = "Wrong username or password. Please Try again."
			redirect_to :action => 'login'
		else
			flash.notice = ["Welcome ", @user_login.full_name, " :)"].join('')
			session[:user_session] = @user_login
			redirect_to :action => 'show', :id => @user_login.id
		end
	end

	def logout()
		@page_name = "Logout"
		reset_session
		flash.notice = "You are now logged out."
		redirect_to :action => "login"
	end

	helper_method :find_user_name
	def find_user_name(ident)
		@user_elem = User.find(ident)
		@user_name = [@user_elem.first_name, @user_elem.last_name].reject(&:empty?).join(' ')
	end

	def search()
		# @q = params[:srch][:text]
		@q = params[:qry]
		puts @q
		# @search_val = User.find_by_sql("SELECT last_name FROM users WHERE last_name LIKE \"%Obama%\";")
		@search_val = Photo.joins(:comments).select("photos.file_name, photos.user_id").where("comment LIKE ?", "%" + @q + "%")
		puts @search_val
		render :json => @search_val
	end
end