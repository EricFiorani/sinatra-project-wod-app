require './config/environment'
require 'sinatra/base'
#Never require 'sinatra' in your extension. You should only ever need to require
# 'sinatra/base'. The reason for this is that require 'sinatra' is what triggers
# the classic style – extensions should never trigger the classic style.
#allows you to run routes
require 'rack-flash'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #session is an object, like a hash, that stores data
    # describing a client's interactions with a website at a given point in time.
    # The session hash lives on the server. Your application can access it via any
    # of your controllers at any point in time.
    #issues the browser a cookie, a secret key or "receipt" that corresponds to a session on the server. A hash
    use Rack::Flash
    set :session_secret, "password_security"
    #  is an encryption key that will be used to create a session_id. A session_id 
    #  is a string of letters and numbers that is unique to a given user's session
    #  and is stored in the browser cookie.
  end

  #Homepage
  get '/' do
    erb :'/index'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  helpers do #adds methods for use in routes, views, and helper methods.
    def logged_in?
      !!current_user
    end

    def current_user
      User.find_by(id: session[:user_id])
      #Finds the first record matching the specified conditions.
      # There is no implied ordering so if order matters, you should specify
      # it yourself. If no record is found, returns nil.
    end
  end

end
