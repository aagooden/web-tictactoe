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
	session[:game] = Game.new(session[:number_of_players], session[:player1], session[:player2], session[:difficulty])
	session[:board_state] = session[:game].board_state
	puts "Here is the board_state you were looking for #{session[:board_state]}"
	redirect "/again"
	# erb :board
end

get '/move' do
	current_move = params[:move]

	#Check to see if current_move has already been played...if so, redirect back to board for another try
	puts "#{session[:game].board_state.include?(current_move)}"
	if session[:game].board_state.include?(current_move.to_i) == false
		puts "GO TO BOARD"
		redirect "/no_dice"
	end

	puts "Step 2, send move to game.play"
	player = session[:game].play(current_move)
	puts "Step 3, returns the array depending on win, tie, none...array is #{player}"
	puts "Step 4, update board_state with the game board state which is #{session[:game].board_state}"
	session[:board_state] = session[:game].board_state

#If last move created a winner or a tie, redirect to /winner
	if player[5] == "winner" || player[5] == "tie"
		session[:winner] = player[0]
		session[:player1_name] = player[1]
		session[:player1_score] = player[2]
		session[:player2_name] = player[3]
		session[:player2_score] = player[4]
		session[:win_tie] = player[5]
		redirect "/winner"
	end


	if player[0] == "Computer"
	elsif player[0] != "Computer" && session[:game].player2_class == Player
		puts "This is where player2 is human and NOT the computer...should go to erb :board at this point"
		erb :board
	else
		puts "If player[0] was not equal Computer, go back through game.play with current move"
		player = session[:game].play(current_move)
		erb :board
	end


#If last move created a winner or a tie, redirect to /winner
	if player[5] == "winner" || player[5] == "tie"
		session[:winner] = player[0]
		session[:player1_name] = player[1]
		session[:player1_score] = player[2]
		session[:player2_name] = player[3]
		session[:player2_score] = player[4]
		session[:win_tie] = player[5]
		redirect "/winner"
	end
	erb :board
end


get "/no_dice" do
	erb :board
end


get "/winner" do
	if session[:win_tie] == "winner"
		session[:message1] = "Way to go #{session[:winner]}, YOU WIN!!"
	else
		session[:message1] = "Better luck next time...IT'S A TIE!"
	end
	erb :winner
end


get "/again" do
	if session[:number_of_players] == "1"
		session[:player2] = "Computer"
	end
	erb :again
end


post "/again" do
	first_move = params[:first_move]

	# Check that player2 is the Computer AND player2 is supposed to go first in the next game
	if session[:game].player2_class == Computer && first_move == "player2"
		session[:game].play_again(false)
		session[:board_state] = session[:game].board_state
		session[:game].play(10) #10 is just a placeholder for calling session[:game].play on the computer's turn
		erb :board
	else
		if first_move == "player2"
			turn = false
		else
			turn = true
		end
		session[:game].play_again(turn)
		session[:board_state] = session[:game].board_state
		erb :board
	end
end
