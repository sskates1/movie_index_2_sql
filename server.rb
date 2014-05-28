require_relative 'server_methods'
require 'sinatra'
require 'pg'

get '/' do
	erb :index
end

get '/movies' do
	erb :movies
end

get '/:movie' do
	erb :movie
end

get '/actors' do
	erb :actors
end

get '/:actor' do
	erb :actor
end