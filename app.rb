require "sinatra"
require "erb"
require_relative "tictactoe_methods.rb"

enable :sessions



get "/" do
	erb :welcome
end


post '/play' do
	session[:number_of_players] = params[:number_of_players]
	session[:player1] = params[:player1]
	session[:player2] = params[:player2]
	session[:difficulty] = params[:difficulty]
	p = Game.new(session[:number_of_players], session[:player1], session[:player2], session[:difficulty])
	p.play
	redirect "/game"
end

get '/game' do
	erb :board.erb
end
