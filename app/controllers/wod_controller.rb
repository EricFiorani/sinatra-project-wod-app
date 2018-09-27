require './config/environment'

class WodController < ApplicationController

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
      @wod = Wod.create(:content => params["content"], :exercise_details => params["exercise_details"],
      :duration => params["duration"], :level => params["level"], :comments => params["comments"])
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
    @wod = Wod.find_by(id: params[:id])
    if current_user.id == @wod.user_id
      erb :'/wods/edit_wod'
    else
      flash[:edit] = "***That Is Not Yours. You Can Not Edit A Post That Doesn't Belong To You!***"
      erb :'/wods/show_wod'
    end
  end

#Edit Wod- Form Submit
  post '/wods/:id' do
    @wod = Wod.find(params[:id])
    if params[:content] == ""
      redirect to "/wods/#{@wod.id}/edit"
    else
      @wod.content = params["content"]
      @wod.exercise_details = params["exercise_details"]
      @wod.duration = params["duration"]
      @wod.level = params["level"]
      @wod.comments = params["comments"]
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
