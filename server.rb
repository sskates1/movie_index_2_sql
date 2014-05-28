require_relative 'server_methods'
require 'sinatra'
require 'pg'

get '/' do
	erb :index
end

get '/movies' do
	@movies = get_movies
	erb :movies
end

get '/movies/:movie_id' do
  @movie_id = params[:movie_id]
  @movie, @cast = get_movie(@movie_id)
	erb :movie
end

get '/actors' do
	@actors = get_actors
	erb :actors
end

get '/actors/:actor_id' do
  @actor_id = params[:actor_id]
	erb :actor
end
