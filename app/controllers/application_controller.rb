require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index
	end

	get "/signup" do
		erb :signup
	end

	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])

		if user.save 
			redirect "/login"
		else 
			redirect "/failure"
		end 
		#cant save the has_secure_password into the database unless our user filled out the password field
		#calling user.save will return false if the user cannot be persisted
		#login if the user is saved, or fail if the user is not saved
	end

	get "/login" do
		erb :login
	end

	post "/login" do
		user = User.find_by(:username => params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/success"
		else 
			redirect "/failure"
		end 
		#ensure that you have a User AND that the user is authenticated
		#if the user is authenticated, set the session user id and redirect to success route
		#check that if the users password matches with the value password_digest - users must have an account and know the passwrod
	end

	get "/success" do
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
