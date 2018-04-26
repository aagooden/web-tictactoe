

class Game

    def initialize
        @board = Board.new
				puts "The initial state of the board is #{@board.state}"
				c = gets.chomp
        system("clear")

        puts "Hello player 1.  What is your name?"
        player1 = gets.chomp
        puts "Thank you #{player1}, you will be X's"
        puts ""
        puts ""
        @player1 = Player.new(player1, "X", @board)

        puts "Hello player 2.  What is your name?"
        player2 = gets.chomp
        @player2 = Computer.new(player2, "O", @board)
        puts "Hello #{player2}, you will be O's"
        puts ""
        puts "Press Enter to start the game"
        gets.chomp
        @turn = true

    end

    def play
        @board.render
        player = ""
        loop do
            if @turn == true
                player = @player1
            else
                player = @player2
            end

            loop do
							p "The class of player is #{player.class}"
											if player.class == Computer
												position = player.move(@board.state)
												puts "The computers move is #{position}"
												z=gets.chomp
											else
				                puts "#{player.name}, enter the number of the position where you would like to play."
				                position = gets.chomp
				                position = position.to_i
											end
                if @board.check(position)
                    @board.change_state(player.piece, position)
                    player.update_positions(position)
                    # puts "Positions = #{player.positions}"
                break
                else
                    puts "That position is occupied...try again!"
                    puts "Press Enter to continue..."
                    gets.chomp
                end
            end

            @board.render
            @turn = !@turn


            if player.check_winner == true
                puts "Congratulations #{player.name}, you WIN!!!!!"
                player.increase_score
                break
            elsif @board.check_tie
                puts "That one was a tie!"
                break
            end
        end
            puts "The current score is..."
            puts ""
            puts "#{@player1.name}: #{@player1.score}"
            puts "#{@player2.name}: #{@player2.score}"
            puts ""
            puts "Would you like to play again? (y or n)"
        loop do
            again = gets.chomp

            if again == "n"
                break
            elsif again == "y"
                @board = Board.new
                @player1.positions=([])
                @player2.positions=([])
                play
            end
            break
        end


    end
end


class Board


    def initialize
        @state = [1,2,3,4,5,6,7,8,9]
    end

		def state
			@state
		end

    def change_state(piece, position)
        @state[position-1] = piece
        puts "The state in change state is now #{@state}"
    end

    def check(position)
        if @state[position -1] == "X" || @state[position -1] == "Y"
            false
        else
            true
        end
    end

    def check_tie
        @state.all? {|i| i.is_a?(String) }
    end

    def render
        p = @state
        system("clear")
        puts ''
        puts ''
        puts ''

        puts "                     | #{p[0]}| #{p[1]}| #{p[2]}|"
        puts "                     ---+--+---"
        puts "                     | #{p[3]}| #{p[4]}| #{p[5]}|"
        puts "                     ---+--+---"
        puts "                     | #{p[6]}| #{p[7]}| #{p[8]}|"

        puts ''
        puts ''
        puts ''

    end

end


test = Board.new
puts test
p test.state

answer = test.state.include?(3)

puts answer
class Player

    attr_accessor :name, :piece

    def initialize(name, piece, board)
        @piece = piece
        @name = name
				@board = board
        @score = 0
        @positions = []
    end

    def update_positions(position)
        @positions.push(position-1)
    end

    def positions
        @positions
    end

    def positions=(new)
        @positions = new
    end

    def increase_score
        @score +=1
    end

    def score
        @score
    end

    def check_winner
        winner = false
        winning_combinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]
        winning_combinations.each do |group|
            contain = 0

            group.each do |num|
              if positions.include?(num)
                contain+=1
            	end
              if contain == 3
                winner = true
              end
            end
        end
        return winner
    end

end


class Computer < Player

  def winning_move(overall_status,move)
    overall_status.each do |temp|
      #check for winning move and play winning move
      if temp.count(self.piece) == 2
        puts "This is group from to win function #{temp}"
        group = temp - [@opponent_piece, piece]
        puts "Here is the move from winning function #{group}"
        if group.empty?
        else
          move = group[0]
        end
      end
    end
    puts "Move from winning_move is #{move}"
    return move
  end


  def block(overall_status,move)
    group = []
    #check for opponent winning position and block
    overall_status.each do |temp|
    if temp.count("X") == 2
        puts "Here is overall_status #{overall_status}"
        puts "Here is the group before deleting #{temp}"
        group = temp - [@opponent_piece, self.piece]
        puts "Here is the group from blocking function #{group}"
        if group.empty?
        else
          move = group[0]
        end
      end
    end
    puts "Move from block is #{move}"
    return move
  end


  def fork_move(overall_status, move, piece, opponent_piece)
    forks = []
    positions = []
    possible =[]
    puts "Here is overall_status in fork_move #{overall_status}"
    puts "Here is the piec I'm deleting this cycle #{piece}"
    puts "The other piece is #{opponent_piece}"
    overall_status.each do |temp|
      if temp.count(piece) == 1 && temp.include?(opponent_piece) == false
        group = temp - [piece]
          forks.push(group)
      end
    end
    puts "Here is the temp array from fork move #{forks}"

    forks.each do |element|
      element.each do |n|
        positions.push(n)
      end
    end
    puts "Here are the positions in fork_move #{positions}"

    #construct an array of possible fork moves
    for x in (1..9) do
      num = positions.count(x)
      if num > 1
        possible.push(num)
      end
    end

    if possible.empty?
      return move
    else
      return possible
    end

    #
    # possible = positions.detect{ |e| positions.count(e) > 1 }
    # if possible == nil
    # else move = possible
    # end
    # if temp.length > 1
    #   puts "This is temp #{temp}"
    #   empty_space_1 = temp[0][0]
    #   puts "empty_space_1 is #{empty_space_1}"
    #   empty_space_2 = temp[0][1]
    #   puts "empty_space_2 is #{empty_space_2}"
    #     if temp[1].include?(empty_space_1)
    #       move = empty_space_1
    #     elsif temp[1].include?(empty_space_2)
    #       move = empty_space_2
    #     end
    # end
    puts "Here is the move from fork move #{move}"
    return move
  end

  def create_two_in_a_row(overall_status, move)
    possible_two_in_a_row = []
    positions = []
    #if there is an empty location that creates a two-in-a row for me(thus forcing opponent to block), play in that location
    #else move to the empty intersection space
    overall_status.each do |combo|
      if combo.count(piece) == 1 && combo.include?(opponent_piece) == false
        possible_two_in_a_row.push(combo)
      end
    end

    possible_two_in_a_row.each do |row|
      row.each do |n|
        positions.push(n)
      end
    end
    puts "Here are possible positions before deleting #{positions}"

    positions = positions - [piece]
    positions = positions - [move]
    puts "Here are the possible positions #{positions}"
    if positions.empty?
      return move
    else
      move = positions[0]
    end
    puts "Here is move from fork_block #{move}"
    return move

  end

  def fork_block(overall_status, move, piece, opponent_piece)







    move = fork_move(overall_status, move, opponent_piece, piece)

    puts "Move coming from block_fork is #{move}"








  end






  def play_center(board,move)
    puts "This is the board from play_center #{board}"
    if board[4] == 5
      move = 5
    end
    return move
  end

  def play_opposite_corner(board,move, piece, opponent_piece)

    corner_opposites = [[0,9],[2,7],[8,1],[6,3]]
    corner_opposites.each do |pair|
    puts "Board corner status is #{board[pair[0]]}"
    puts "Pair [1] is #{[pair[1]]}"
      if board[pair[0]] == opponent_piece && board[pair[1]-1] == pair[1]
        puts "Board corner status is #{board[pair[0]]} and opponent_piece is #{opponent_piece}"

        move = pair[1]
      end
    end
    puts "Move from play_opposite_corner is #{move}"
    return move
  end

  def random_move(board,move)
      board.delete(@opponent_piece)
      board.delete(self.piece)
      move = board.sample
      puts "This is move inside computer #{move}"
      puts "This is the board state #{board}"
      puts "This is @board #{@board.state}"
        z=gets.chomp
    # puts "What do you want computer move to be?"
    # move = gets.chomp
    # move = move.to_i
    puts "Move coming form random is #{move}"
    return move
  end


  def move(board_state)
    move = ""
    board = Array.new
    if self.piece == "O"
      @opponent_piece = "X"
    else
      @opponent_piece = "O"
    end
    #if the following routine is not performed, any changes in a variable set to @board.state will subsequently change @board.state...
    # This is essentially insulating @board.state from changes
    board_state.each do |position|
      board.push(position)
    end

    overall_status = []
    combos = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]
      combos.each do |group|
        temp = []
          group.each do |position|
            temp.push(board[position])
          end
          overall_status.push(temp)
      end


      if move == ""
        move = winning_move(overall_status, move)
      end

      if move == ""
        move = block(overall_status, move)
      end

      if move == ""
        move = fork_move(overall_status, move, self.piece, @opponent_piece)
      end

      if move == ""
        move = fork_block(overall_status, move, self.piece, @opponent_piece)
      end

      if move == ""
        move = play_center(board,move)
      end

      if move == ""
        move = play_opposite_corner(board, move, self.piece, @opponent_piece)
      end

      if move == ""
        move = random_move(board,move)
      end

  return move


  end



  # def random_move
  #   board = []
  #
	# 	board_state = @board.state
  #   p @board.state
  #   #if the following routine is not performed, any changes in a variable set to @board.state will subsequently change @board.state...
  #   # This is essentially insulating @board.state from changes
  #   board_state.each do |position|
  #     board.push(position)
  #   end
  #   p board
  #
  #   board.delete("X")
  #   board.delete("O")
  #   move = board.sample
  #   puts "This is move inside computer class #{move}"
  #   puts "This is the cheese state #{board_state}"
  #   puts "This is @board #{@board.state}"
  #
	# 		z=gets.chomp
	# 	return move
  #
	# end

end

p = Game.new
p.play