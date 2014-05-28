require_relative 'server_methods'
<<<<<<< HEAD
require sinatra
require pg

=======
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
>>>>>>> 0f4e57298af1f53a66cbbb1003307cc5b81e50fd
