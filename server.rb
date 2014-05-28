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

get '/:movie' do
	erb :movie
end

get '/actors' do
	@actors = get_actors
	erb :actors
end

get '/:actor' do
	erb :actor
end