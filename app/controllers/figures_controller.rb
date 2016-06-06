class FiguresController < ApplicationController

  get '/figures' do
    erb :"/figures/index"
  end

  get '/figures/new' do
    erb :"/figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    @figure.titles << Title.create(name: params[:title][:name])
    @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/edit"
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(name: params[:figure][:name])

    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    redirect "figures/#{@figure.id}"
  end
end
