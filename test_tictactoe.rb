require "minitest/autorun"
require_relative "tictactoe_methods.rb"

class Tictactoe_test < Minitest::Test

	def test_boolean
		assert_equal(true, true)
	end


	# def test_fork
  #   @board=Board.new
  #   state = ["O",2,3,4,5,"X",7,"X",9]
  #   @player1 = Player.new("Aaron", "X", @board)
  #   @player2 = Computer.new("Computer", "O", @board)
	#
	# 	assert_equal(7, @player2.move(state))
	# end
	#
  # def test_fork
  #   @board=Board.new
  #   state = [1,"O","X","X",5,6,"O",8,9]
  #   @player1 = Player.new("Aaron", "X", @board)
  #   @player2 = Computer.new("Computer", "O", @board)
  #   assert_equal(8, @player2.move(state))
  # end

  def test_fork_move
		@board=Board.new
    state = ["O",2,3,4,"X",6,7,8,9]
    @player1 = Player.new("Aaron", "X", @board)
    @player2 = Computer.new("Computer", "O", @board)
		possible = [7,3]
		actual = @player2.move(state)
		puts "The actual move is #{actual}"
		contain = possible.include?(actual)
    assert_equal(true, contain)
  end

#   def test_block_fork_1
#     @board=Board.new
#     state = ["O",2,3,4,"X",6,7,8,"X"]
#     @player1 = Player.new("Aaron", "X", @board)
#     @player2 = Computer.new("Computer", "O", @board)
# 		possible = [2,4]
# 		actual = @player2.move(state)
# 		contain = possible.include?(actual)
#     assert_equal(true, contain)
#   end
#
# 	def test_move_to_empty_corner
# 		@board=Board.new
# 		state = ["O",2,3,4,"X",6,7,8,9]
# 		@player1 = Player.new("Aaron", "X", @board)
# 		@player2 = Computer.new("Computer", "O", @board)
# 		assert_equal(9, @player2.move(state))
# 	end
#
#   def test_opposite_corner
#     @board=Board.new
#     state = ["X","X","O","O","O","X","X",8,9]
#     @player1 = Player.new("Aaron", "X", @board)
#     @player2 = Computer.new("Computer", "O", @board)
#     assert_equal(9, @player2.move(state))
#   end
#
# 	def test_move_to_center_if_open
# 		@board=Board.new
# 		state = ["X",2,3,4,5,6,7,8,9]
# 		@player1 = Player.new("Aaron", "X", @board)
# 		@player2 = Computer.new("Computer", "O", @board)
# 		assert_equal(5, @player2.move(state))
# 	end
#
# 	def test_move_to_center_if_open_2
# 		@board=Board.new
# 		state = [1,2,3,4,5,6,7,"X",9]
# 		@player1 = Player.new("Aaron", "X", @board)
# 		@player2 = Computer.new("Computer", "O", @board)
# 		assert_equal(5, @player2.move(state))
# 	end
#
# # initialize(number_of_players, player1, player2, difficulty)
# def test_new_game
#   @game=Game.new(1, "Aaron", "Computer", 2)
#   assert_equal([1,2,3,4,5,6,7,8,9], @game.board_state)
# 	assert_equal(Computer, @game.player2_class)
# 	assert_equal(true, @game.turn)
# 	@game.play(1) #this call flips @game.turn and changes @game.board_state
# 	assert_equal(false, @game.turn)
# 	assert_equal(["X",2,3,4,5,6,7,8,9], @game.board_state)
# end
#
# def test_winning_move
# 	@board=Board.new
# 	state = ["O","X",3,"O","X","X",7,8,9]
# 	@player1 = Player.new("Aaron", "X", @board)
# 	@player2 = Computer.new("Computer", "O", @board)
# 	assert_equal(7, @player2.move(state))
# end
#
# def test_winning_move_with_possible_block_present
# 	@board=Board.new
# 	state = ["X","X","O","O","O",6,"X",8,"X"]
# 	@player1 = Player.new("Aaron", "X", @board)
# 	@player2 = Computer.new("Computer", "O", @board)
# 	assert_equal(6, @player2.move(state))
# end
#
# def test_block
# 	@board=Board.new
# 	state = [1,2,"X",3,"X",6,7,8,"O"]
# 	@player1 = Player.new("Aaron", "X", @board)
# 	@player2 = Computer.new("Computer", "O", @board)
# 	assert_equal(7, @player2.move(state))
# end
#
# def test_block_2
# 	@board=Board.new
# 	state = [1,"X","O",3,"X",6,7,"O","X"]
# 	@player1 = Player.new("Aaron", "X", @board)
# 	@player2 = Computer.new("Computer", "O", @board)
# 	assert_equal(1, @player2.move(state))
# end



	# def test_block_fork_2
	#   @board=Board.new
	#   state = [["X",2,3],[4,"O","X"],[7,8,9]]
	#   @player1 = Player.new("Aaron", "X", @board)
	#   @player2 = Computer.new("Computer", "O", @board)
	# 	possible = [3]
	# 	actual = @player2.fork_block(state, "", "O", "X")
	# 		puts "Actual is TEST #{actual}"
	# 	contain = possible.include?(actual)
	#   assert_equal(true, contain)
	# end

end
