require_relative 'board'

class BoardController
  
#  attr_reader :last_error
#  attr_reader :last_move_input
  
  def initialize(board)
    @board = board
    @next_player_white = true
    @has_move_so_not_in_check = true
  end
  
  # Convert a user location like g5 to a pair of indexes we can use to address
  # our @layout array.
  def user_location_to_indexes(user_location)
    column = "abcdefgh".index(user_location[0])
    row = user_location[1].to_i - 1
    
    [column, row]
  end
  
  def play_move(move_input)
    @last_move_input = move_input
    @last_error = nil
    validation = MoveSyntaxValidation.new(move_input)
    if (validation.valid?)
      syntactically_valid_move = validation.syntactically_valid_move
      
      from = user_location_to_indexes(syntactically_valid_move[0, 2])
      to = user_location_to_indexes(syntactically_valid_move[2, 2])

      move_possible_error = @board.move_possible(@next_player_white, from, to)
      
      if (move_possible_error.nil?)
        @board.move_piece(from, to)
        @next_player_white = !@next_player_white
        @check = @board.in_check?(@next_player_white)
        @has_move_so_not_in_check = @board.has_move_so_not_in_check?(@next_player_white)
      else
        @last_error = move_possible_error
      end    
      
    else
      @last_error = validation.error
    end
  end
  
  def done?
    !@has_move_so_not_in_check
  end
  
  def board_status
    stati = []
    stati << "Last move was #{@last_move_input}" unless @last_move_input.nil?
    stati << "There was a problem with the last move: #{@last_error}" unless @last_error.nil?
    if (!@has_move_so_not_in_check)
      if (@check)
        stati << "CHECKMATE!"
      else
        stati << "STALEMATE!"
      end
    else
      stati << "CHECK!" unless !@check
      stati << "Next player to move is " + (@next_player_white ? "white" : "black")
    end
  end
  
end