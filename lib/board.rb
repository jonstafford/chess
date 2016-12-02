require_relative 'colors'
require_relative 'move_syntax_validation'

class Board
  include Colors
  
  def initialize(layout)
    # @layout is an array of row arrays. So location [x, y] is at @layout[y][x].
    @layout = layout
  end
  
  # Answers an array of lines which can be printed to the console to display 
  # the board.
  def board_view
    lines = []
    
    count = 0
    @layout.each_with_index do |row, y|
      l = (y + 1).to_s + "  "
      row.each do |square|
        count += 1
        l += square.square_view(count % 2 == 0)
      end
      count += 1 # Because next row begins with the same color as last row ends
      lines.unshift(l)
    end
    
    lines.unshift("") # Blank line before
    
    lines << ""
    lines << "   " + "abcdefgh"
    lines << "" # Blank line after
    
    lines 
  end
  
  def move_piece(from, to)
    @layout[from[1]][from[0]], @layout[to[1]][to[0]] =  @layout[to[1]][to[0]], @layout[from[1]][from[0]]
  end
  
  def piece_at_location(location)
    @layout[location[1]][location[0]]
  end

end