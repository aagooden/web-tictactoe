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

  # def test_fork_2
  #   @board=Board.new
  #   state = [1,"O","X","X",5,6,"O",8,9]
  #   @player1 = Player.new("Aaron", "X", @board)
  #   @player2 = Computer.new("Computer", "O", @board)
  #   assert_equal(8, @player2.move(state))
  # end

  # def test_fork_move
	# 	@board=Board.new
  #   state = ["O",2,3,4,"X",6,7,8,9]
  #   @player1 = Player.new("Aaron", "X", @board)
  #   @player2 = Computer.new("Computer", "O", @board)
	# 	possible = [7,3]
	# 	actual = @player2.move(state)
	# 	puts "The actual move is #{actual}"
	# 	contain = possible.include?(actual)
  #   assert_equal(true, contain)
  # end

	def test_move_to_empty_corner
		@board=Board.new
		state = ["O",2,3,4,"X",6,7,8,9]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		function = @player2.empty_corner(state, "")
		assert_equal(9, function)
	end

	def test_move_to_empty_corner_2
		@board=Board.new
		state = [1,2,3,4,"X",6,7,8,"O"]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		function = @player2.empty_corner(state, "")
		assert_equal(7, function)
	end

  def test_opposite_corner_1
    @board=Board.new
    state = ["X","X","O","O","O","X","X",8,9]
    @player1 = Player.new("Aaron", "X", @board)
    @player2 = Computer.new("Computer", "O", @board)
		function = @player2.play_opposite_corner(state, "", "O", "X")
    assert_equal(9, function)
  end

	def test_opposite_corner_2
    @board=Board.new
    state = ["X","X",3,"X","O",6,"X","O","X"]
    @player1 = Player.new("Aaron", "X", @board)
    @player2 = Computer.new("Computer", "O", @board)
		function = @player2.play_opposite_corner(state, "", "O", "X")
    assert_equal(3, function)
  end

	def test_opposite_corner_3
		@board=Board.new
		state = ["X",2,3,4,"O",6,7,8,9]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		function = @player2.play_opposite_corner(state, "", "O", "X")
		assert_equal(9, function)
	end

	def test_move_to_center_if_open_1
		@board=Board.new
		state = ["X",2,3,4,5,6,7,8,9]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		function = @player2.play_center(state,"")
		assert_equal(5, function)
	end

	def test_move_to_center_if_open_2
		@board=Board.new
		state = [1,2,3,4,5,6,7,"X",9]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		function = @player2.play_center(state,"")
		assert_equal(5, function)
	end

	def test_empty_edge
		@board=Board.new
		state = ["X",2,"O","O","X","X","X","O","O"]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		function = @player2.empty_edge(state,"")
		assert_equal(2, function)
	end

	def test_new_game_board_state
	  @game=Game.new(1, "Aaron", "Computer", 2)
		function = @game.board_state
	  assert_equal([1,2,3,4,5,6,7,8,9], function)
	end

	def test_new_game_player2_class
	  @game=Game.new(1, "Aaron", "Computer", 2)
		function = @game.player2_class
		assert_equal(Computer, function)
	end

	def test_new_game_turn
	  @game=Game.new(1, "Aaron", "Computer", 2)
		function = @game.turn
		assert_equal(true, function)
	end

	def test_new_game_after_first_move
	  @game=Game.new(1, "Aaron", "Computer", 2)
		@game.play(1) #this call flips @game.turn and changes @game.board_state
		function = @game.turn
		assert_equal(false, function)
	end

	def test_new_game_after_first_move_2
	  @game=Game.new(1, "Aaron", "Computer", 2)
		@game.play(1) #this call flips @game.turn and changes @game.board_state
		function = @game.board_state
		assert_equal(["X",2,3,4,5,6,7,8,9], function)
	end

	def test_winning_move
		@board=Board.new
		state = ["O","X",3,"O","X","X",7,8,9]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		assert_equal(7, @player2.move(state))
	end

	def test_winning_move_with_possible_block_present
		@board=Board.new
		state = ["X","X","O","O","O",6,"X",8,"X"]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		assert_equal(6, @player2.move(state))
	end

	def test_block
		@board=Board.new
		state = [1,2,"X",3,"X",6,7,8,"O"]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		assert_equal(7, @player2.move(state))
	end

	def test_block_2
		@board=Board.new
		state = [1,"X","O",3,"X",6,7,"O","X"]
		overall_status=[[1,"X","O"],[3,"X",6],[7,"O","X"],[1,4,7],["X","X","O"],["O",6,"X"],[1,"X","X"],[7,"X","O"]]
		@player1 = Player.new("Aaron", "X", @board)
		@player2 = Computer.new("Computer", "O", @board)
		@player2.move(state)
		function = @player2.block(overall_status,"")
		assert_equal(1, function)
	end

	  def test_fork_block_1
	    @board=Board.new
	    overall_status = [["O",2,3],[4,"X",6],[7,8,"X"],["O",4,7],[2,"X",8],[3,6,"X"],["O","X","X"],[7,"X",3]]
	    @player1 = Player.new("Aaron", "X", @board)
	    @player2 = Computer.new("Computer", "O", @board)
			possible = [2,4]
			actual = @player2.fork_block(overall_status, "", "O", "X")
			contain = possible.include?(actual)
	    assert_equal(true, contain)
	  end

	def test_fork_block_2_with_only_one_fork_possibility
		  @board=Board.new
		  overall_status = [["X",2,3],[4,"O","X"],[7,8,9],["X",4,7],[2,"O",8],[3,"X",9],["X","O",9],[7,"O",3]]
		  @player1 = Player.new("Aaron", "X", @board)
		  @player2 = Computer.new("Computer", "O", @board)
			actual = @player2.fork_block(overall_status, "", "O", "X")
		  assert_equal(3, actual)
	end

	  def test_fork_block_3
	    @board=Board.new
	    overall_status = [[1,2,"X"],[4,"O",6],["X",8,9],[1,4,"X"],[2,"O",8],["X",6,9],[1,"O",9],["X","O","X"]]
	    @player1 = Player.new("Aaron", "X", @board)
	    @player2 = Computer.new("Computer", "O", @board)
			possible = [2,4,6,8]
			actual = @player2.fork_block(overall_status, "", "O", "X")
			contain = possible.include?(actual)
	    assert_equal(true, contain)
	  end





end
