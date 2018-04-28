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
	$game = Game.new(session[:number_of_players], session[:player1], session[:player2], session[:difficulty])
	session[:board_state] = $game.board_state
	erb :board
end

get '/move' do
	current_move = params[:move]
	# puts "From app /move The current move is #{current_move}"

	puts "Step 2, send move to game.play"
	player = $game.play(current_move)
	puts "Step 3, returns the array depending on win, tie, none...array is #{player}"
	puts "Step 4, update board_state with the game board state which is #{$game.board_state}"
	session[:board_state] = $game.board_state

	puts "From app /move This is player array before checking for winner #{player}"
	puts "player[5] is #{player[5]}"
	puts "If player[5] is winner, send to erb:winner"
	if player[5] == "winner" || player[5] == "tie"
		session[:winner] = player[0]
		session[:player1_name] = player[1]
		session[:player1_score] = player[2]
		session[:player2_name] = player[3]
		session[:player2_score] = player[4]
		redirect "/winner"
	end


	if player[0] == "Computer"
	else
		puts "If player[0] didnt equal Computer, go back through game.play with current move"
		player = $game.play(current_move)
	end

puts "if player[5] is winner, send to erb:winner "
	if player[5] == "winner" || player[5] == "tie"
		session[:winner] = player[0]
		session[:player1_name] = player[1]
		session[:player1_score] = player[2]
		session[:player2_name] = player[3]
		session[:player2_score] = player[4]
		redirect "/winner"
	end

	puts "From app /move The current board_state is #{session[:board_state]}"
	puts "sending to erb:board to render board"
	erb :board
end

get "/winner" do
	erb :winner
end

post "/again" do
	puts "This is $game.turn #{$game.turn}"
	if $game.turn == false #means the last player to play was human
			puts "test 1111111111"


		$game.play_again
			puts "test 2222222222"
		session[:board_state] = [1,2,3,4,5,6,7,8,9]
		puts "test 33333333333"
		$game.play(10)
		puts "test 4444444444"
	else #if last person was computer
	session[:board_state] = [1,2,3,4,5,6,7,8,9]
	$game.play_again
	erb :board
end
session[:board_state] = $game.board_state
erb :board
end
