require 'colors'

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
  
  def play_move(move)
  end
  
  def done?
    false
  end
end