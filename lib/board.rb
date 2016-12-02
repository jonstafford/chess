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
      count += 1 # Because next row begins with the same color as last row ends
      lines.unshift(l)
    end
    
    lines 
  end
  

end