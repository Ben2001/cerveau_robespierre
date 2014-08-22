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
require 'pry'

set :database, "sqlite3:///foo.sqlite3"
enable :sessions

uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

def tweets
  REDIS.keys("robonova:tweet:*").map { |x| JSON.parse REDIS.get x }
end

def remettre_a_zero(redis)
  redis = REDIS
  redis.hset "votes", "counter1", 0
  redis.hset "votes", "counter2", 0
  redis.hset "votes", "counter3", 0
end

get '/' do
  @redis = REDIS
  @tracks = Track.order("position")
  @tweets = tweets
  erb :twitter
end

get '/fresh_tweets' do
  @redis = REDIS
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
  redis = REDIS
  if redis.get("demarrer") == "off"
    remettre_a_zero(redis)
    redis.hset "votes", "track1", "#{params[:hash1]}"
    redis.hset "votes", "track2", "#{params[:hash2]}"
    redis.hset "votes", "track3", "#{params[:hash3]}"
    redis.set "demarrer", "on"
    return 'Arrêter'
  else
    redis.set "demarrer", "off"
    return 'Démarrer'
  end
end

get "/update_vote" do
  redis = REDIS
  if redis.get("demarrer") == "off"
    "stop polling".to_json
  else
      {vote_1: redis.hget("votes", "counter1"),
      vote_2: redis.hget("votes", "counter2"),
      vote_3: redis.hget("votes", "counter3")}.to_json
  end
end

post "/remettre_a_zero" do
  redis = REDIS
  remettre_a_zero(redis)
end