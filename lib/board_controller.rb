require 'board'

class BoardController
  
  def initialize(board)
    @board = board
  end
  
  # Convert a user location like g5 to a pair of indexes we can use to address
  # our @layout array.
  def user_location_to_indexes(user_location)
    column = "abcdefgh".index(user_location[0])
    row = user_location[1].to_i - 1
    
    [column, row]
  end
  
  def play_move(move_input)
    validation = MoveSyntaxValidation.new(move_input)
    if (validation.valid?)
      syntactically_valid_move = validation.syntactically_valid_move
      
      from = user_location_to_indexes(syntactically_valid_move[0, 2])
      to = user_location_to_indexes(syntactically_valid_move[2, 2])
    
      piece = piece_at_location(from)
      possibility = piece.is_move_possible(@board, from, to)
      
      if (possibility.possible?)
        # Do something
      else
        error = possibility.error
      end
      
    else
      error = validation.error
    end
  end
  
  def done?
    false
  end
  
end