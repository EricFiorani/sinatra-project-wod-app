require './config/environment'
require 'sinatra/base'
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

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      User.find_by(id: session[:user_id])
    end
  end

end
