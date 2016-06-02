class LandmarksController < ApplicationController

  get '/landmarks' do
    erb :"/landmarks/index"
  end

  get '/landmarks/new' do
    erb :"/landmarks/new"
  end

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    if !params["figure"]["name"].empty?
      @figure = Figure.find_or_create_by(name: params["figure"]["name"])
      @landmark.figure_id = @figure.id
      @figure.landmarks << @landmark
      @figure.save
    end
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :"/landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params["id"])
    erb :"/landmarks/edit"
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    if !params[:landmark][:name].empty?
      @landmark.update(params[:landmark])
    end
    if !params["figure"]["name"].empty?
      @figure = Figure.find_or_create_by(name: params["figure"]["name"])
      @landmark.figure_id = @figure.id
      @figure.landmarks << @landmark
      @figure.save
    end
    @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end

end
