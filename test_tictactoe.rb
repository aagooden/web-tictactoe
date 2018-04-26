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

  def test_fork
    @board=Board.new
    state = [1,"O","X","X",5,6,"O",8,9]
    @player1 = Player.new("Aaron", "X", @board)
    @player2 = Computer.new("Computer", "O", @board)
    assert_equal(8, @player2.move(state))
  end

  def test_fork_2
    @board=Board.new
    state = [1,2,"X","X","O",6,7,8,"O"]
    @player1 = Player.new("Aaron", "X", @board)
    @player2 = Computer.new("Computer", "O", @board)
    assert_equal(1, @player2.move(state))
  end

  def test_block_fork
    @board=Board.new
    state = ["O",2,3,4,"X",6,7,8,"X"]
    @player1 = Player.new("Aaron", "X", @board)
    @player2 = Computer.new("Computer", "O", @board)
    assert_equal(2, @player2.move(state))
  end

  def test_opposite_corner
    @board=Board.new
    state = ["X","X","O","O","O","X","X",8,9]
    @player1 = Player.new("Aaron", "X", @board)
    @player2 = Computer.new("Computer", "O", @board)
    assert_equal(9, @player2.move(state))
  end



end
