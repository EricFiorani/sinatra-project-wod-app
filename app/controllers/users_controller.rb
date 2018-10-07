require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController

#Signup Page - does not let a logged in user view the signup page
  get '/signup' do
    if logged_in?
      redirect to '/wods'
    else
      erb :'/users/create_user'
    end
  end

#Signup Page - Form Submit
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(
        :username => params["username"],
        :email => params["email"],
        :password => params["password"]
      )
      @user.save
      session[:user_id] = @user.id
      redirect to '/wods'
    end
  end

#Login Page
  get '/login' do
    if logged_in?
      @user = current_user
      redirect to "/users/#{@user.slug}"
    else
      erb :"/users/login"
    end
  end

#Login Page- Form Submit
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      #authenticate will try to match the salted hashed versions of the password
      #via has_secure_password from users model, if it can't it will return false
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
    else
      flash[:message] = "***Incorrect username or password, please try again!***"
      erb :"/users/login"
    end
  end

#User's Show page
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if current_user == @user
      erb :'/users/show'
    else
      redirect to '/wods'
    end
  end

end
