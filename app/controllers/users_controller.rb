require './config/environment'
require 'sinatra/base'

class WodsController < ApplicationController

#All Wods
  get '/wods' do
    if logged_in?
      @user = current_user
      erb :'/wods/wods'
    else
      redirect to "/login"
    end
  end

#New Wod
  get '/wods/new' do
    if logged_in?
      erb :'/wods/create_wod'
    else
      redirect to "/login"
    end
  end

#New Wod- Form Submit
  post '/wods' do
    if params[:content] == ""
      redirect '/wods/new'
    else
      @wod = Wod.create(:content => params["content"])
      @wod.user_id = current_user.id
      @wod.save
      redirect to "/wods/#{@wod.id}"
    end
  end

#Show Wod
  get '/wods/:id' do
    if logged_in?
      @wod = Wod.find(params[:id])
      erb :'/wods/show_wod'
    else
      redirect to "/login"
    end
  end

#Edit Wod
  get '/wods/:id/edit' do
    if logged_in?
      @wod = Wod.find(params[:id])
      erb :'/wods/edit_wod'
    else
      redirect to "/login"
    end
  end

#Edit Wod- Form Submit
  post '/wods/:id' do
    @wod = Wod.find(params[:id])
    if params[:content] == ""
      redirect to "/wods/#{@wod.id}/edit"
    else
      @wod.content = params["content"]
      @wod.save
      redirect to "/wods/#{@wod.id}"
    end
  end

#Delete Wod Action
  delete '/wods/:id' do
    @wod = Wod.find_by_id(params[:id])
    if @wod.user_id == current_user.id
      @wod.delete
    end
      redirect to "/wods"
  end


end
