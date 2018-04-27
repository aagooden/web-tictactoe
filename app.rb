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
	puts "Here is number of players #{session[:number_of_players]}"
	puts "Here is player 1 #{session[:player1]}"
	puts "Here is player 2 #{session[:player2]}"
	puts "Here is difficulty #{session[:difficulty]}"

	redirect "/game"
end

get '/game' do
	@@game = Game.new(session[:number_of_players], session[:player1], session[:player2], session[:difficulty])
	session[:board_state] = @@game.board_state
	puts "Here is session[:board_state] #{session[:board_state]}"
	# game.play
	erb :board
end

get '/move' do
	session[:move] = params[:move]
	@@game.play(session[:move])
	session[:board_state] = @@game.board_state
	erb :board
end
