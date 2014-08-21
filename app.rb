# coding: utf-8

require 'bundler'
Bundler.require
require 'sinatra'
require 'dotenv'
Dotenv.load
require './model_vote'
require './model_tweet'
require './track.rb'
require './robot'
# require './systeme_de_vote'
require 'pry'

set :database, "sqlite3:///foo.sqlite3"
enable :sessions

uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

def tweets
  REDIS.keys("robonova:tweet:*").map { |x| JSON.parse REDIS.get x }
end

def remettre_a_zero(redis)
  redis.set "PSG", 0
  redis.set "obama", 0
  redis.set "justin bieber", 0
end

get '/' do
  @redis = Redis.new
  @tracks = Track.order("position")
  @tweets = tweets
  erb :twitter
end

get '/fresh_tweets' do
  @redis = Redis.new
  @tweets = tweets
  erb :tweets, layout: false
end

post '/' do
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
    Track.create_audio_file(params[:file][:filename])
  end
  redirect to ('/')
end

post '/remove_track' do
  Track.destroy_from_title(params[:name])
end

post "/say" do
  if params[:audio_files]
    params[:audio_files].each do |audio_file|
     `aplay "#{File.join(File.dirname(__FILE__), "public", audio_file)}"` #aplay ne lit pas les mp3
   end
 end
 redirect to ('/')
end

post '/doing' do
  Robot.new.send(params[:what])
  redirect to ('/')
end

post '/sort_url' do
  params[:tracks].each do |index, track|
    Track.find_by(title: track["title"]).update position: index
  end
end

post '/vote' do
  #puts params.inspect
  #TODO ici params[:hash1] params[:hash2] params[:hash3] pour le watcher
  redis = Redis.new
  if redis.get("demarrer") == "off"
    remettre_a_zero(redis)
    redis.set "demarrer", "on"
    return 'Arrêter'
  else
    redis.set "demarrer", "off"
    return 'Démarrer'
  end
end

get "/update_vote" do
  redis = Redis.new
  if redis.get("demarrer") == "off"
    "stop polling".to_json
  else
    {vote_1: redis.get('PSG'),
      vote_2: redis.get('obama'),
      vote_3: redis.get('justin bieber')}.to_json
  end
end

post "/remettre_a_zero" do
  redis = Redis.new
  remettre_a_zero(redis)
end