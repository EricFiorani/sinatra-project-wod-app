require './config/environment'
require 'sinatra/base'
#Never require 'sinatra' in your extension. You should only ever need to require
# 'sinatra/base'. The reason for this is that require 'sinatra' is what triggers
# the classic style – extensions should never trigger the classic style.
require 'rack-flash'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #issues the browser a cookie, a secret key or "receipt" that corresponds to a session on the server. A hash
    use Rack::Flash
    set :session_secret, "password_security"
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
