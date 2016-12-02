require 'colors'
require 'move_syntax_validation'

class Board
  include Colors
  
  def initialize(layout)
    @layout = layout
  end
  
  # Answers an array of lines which can be printed to the console to display 
  # the board.
  def board_view
    lines = []
    
    count = 0
    @layout.each do |row|
      l = ""
      row.each do |square|
        count += 1
        l += square.square_view(count % 2 == 0)
      end
      lines << l
    end
    
    lines 
  end
  
  def play_move(move_input)
    validation = MoveSyntaxValidation.new(move_input)
    if (validation.valid?)
      syntactically_valid_move = validation.syntactically_valid_move
    else
      error = validation.error
    end
    # TODO 
  end
  
  def done?
    false
  end
end