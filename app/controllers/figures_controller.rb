class FiguresController < ApplicationController

  get '/figures' do
    erb :"/figures/index"
  end

  get '/figures/new' do
    erb :"/figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params["title"]["name"].empty?
      @title = Title.find_or_create_by(name: params["title"]["name"])
      @figure.titles = @title
      @title.save
    end
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.find_or_create_by(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
      @landmark.save
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    if !params[:figure][:name].empty?
      @figure.update(params[:figure])
    end
    if !params[:title][:name].empty? && !@figure.title_ids.include?(params[:figure][:title_ids])
      @title = Title.find_or_create_by(name: params[:title][:name])
      @figure.title_ids = params[:figure][:title_ids]
      @figure.titles << @title
      @title.figures << @figure
      @title.save
    elsif !@figure.title_ids.include?(params[:figure][:title_ids]) && params["title"]["name"].empty?
      @figure.title_ids = params[:figure][:title_ids]
    elsif @figure.title_ids.include?(params[:figure][:title_ids]) && !params["title"]["name"].empty?
      @title = Title.find_or_create_by(name: params["landmark"]["name"])
      @figure.titles << @title
      @title.figure_id = @figure.id
      @title.save
    end
    if !params["landmark"]["name"].empty? && !@figure.landmark_ids.include?(params[:figure][:landmark_ids])
      @landmark = Landmark.find_or_create_by(name: params["landmark"]["name"])
      @figure.landmark_ids = params[:figure][:landmark_ids]
      @figure.landmarks << @landmark
      @landmark.figure_id = @figure.id
      @landmark.save
    elsif !@figure.landmark_ids.include?(params[:figure][:landmark_ids]) && params["landmark"]["name"].empty?
      @figure.landmark_ids = params[:figure][:landmark_ids]
    elsif @figure.landmark_ids.inclulde?(params[:figure][:landmark_ids]) && !params["landmark"]["name"].empty?
      @landmark = Landmark.find_or_create_by(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
      @landmark.figure_id = @figure.id
      @landmark.save
    end
    @figure.save
    erb :"/figures/show", locals:{message: "Successfully Edited Figure."}
  end

end
