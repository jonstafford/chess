require_relative 'board'

class BoardController
  
#  attr_reader :last_error
#  attr_reader :last_move_input
  
  def initialize(board)
    @board = board
    @next_player_white = true
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
    
      piece = @board.piece_at_location(from)
      target_piece = @board.piece_at_location(to)
      
      if (from == to)
        @last_error = "Start location is same as target location"
      elsif (piece.white? != @next_player_white)
        @last_error = "Start location is not one of your pieces!"
      elsif (!target_piece.empty? && target_piece.white? == @next_player_white)
        @last_error = "Target location already has one of your pieces!"
      else
      
        layout = @board.layout
      
        possibility = piece.is_move_possible(layout, from, to)
      
        if (possibility.possible?)
          from_piece = @board.piece_at_location(from)
          to_piece = @board.piece_at_location(to)
          @board.move_piece(from, to)
          # Ensure the move doesn't mean the player put themselves in check
          if (@board.in_check?(@next_player_white)) 
            @board.undo_move_piece(from, from_piece, to, to_piece)
            @last_error = "That move would put the " + (@next_player_white ? "white" : "black") + " player in check."
          else
            @next_player_white = !@next_player_white
            @check = @board.in_check?(@next_player_white)
          end
        else
          @last_error = possibility.error
        end
      end
      
    else
      @last_error = validation.error
    end
  end
  
  def done?
    false
  end
  
  def board_status
    stati = []
    stati << "Last move was #{@last_move_input}" unless @last_move_input.nil?
    stati << "There was a problem with the last move: #{@last_error}" unless @last_error.nil?
    stati << "CHECK!" unless !@check
    stati << "Next player to move is " + (@next_player_white ? "white" : "black")
  end
  
end