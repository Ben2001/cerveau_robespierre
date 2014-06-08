require 'bundler'
Bundler.require
require 'sinatra'
Dotenv.load
require './model_vote'
require './model_tweet'
require './track.rb'

set :database, "sqlite3:///foo.sqlite3"

enable :sessions #permet de stocker une variable dans une session et de pouvoir l'utiliser partout dans l'app

get '/' do
  @tracks = Track.order("position")
  erb :text_to_speech
end

post '/' do #avec tts => pour envoyer des éléments des blocs tweet et TTS vers le player audio
  input = params[:input] || params[:tweet].to_s
  if input
    Track.create_track(input)
  end
  redirect to ('/')
end

post '/upload' do
  if params[:file][:type].include?('audio')
    File.open("public/tracks/#{params[:file][:filename]}", "wb") do |f|
      f.write(params[:file][:tempfile].read)
    end
    Track.create_track(params[:file][:filename])
  end
  redirect to ('/')
end

post '/remove_track' do
  Track.destroy_from_title(params[:name])
end

post "/say" do
  if params[:sentences]
    params[:sentences].each do |sentence|
      `aplay "/home/ben/workspace/Robo-Nova/Robespierre_Demo/public/#{sentence}"`
    end
  end
  redirect to ('/')
end

post '/doing' do
  `aplay "/home/ben/workspace/Robo-Nova/Robespierre_Demo/public/doing/usain_bolt.mp3"`
  redirect to ('/')
end