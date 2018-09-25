require './config/environment'
require 'sinatra/base'

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
      redirect to '/wods'
    else
      erb :'/users/login'
    end
  end

#Login Page- Form Submit
  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/wods"
    else
      redirect "/login"
    end
  end

#User's Show page
  get '/users/:slug' do
    @user = User.find_by_slug(:slug)
    if @user.logged_in?
      erb :'/users/show'
    else
      redirect to '/wods'
    end
  end

end
