require './config/environment'

class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      @user = current_user
      redirect to "/wods/#{@user.slug}"
    else
      erb :'/users/create_user'
    end
  end

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

  get '/login' do
    if logged_in?
      @user = current_user
      redirect to "/wods/#{@user.slug}"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/wods"
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user.logged_in?
      erb :'/users/show'
    else
      redirect to '/wods'
    end
  end
end
