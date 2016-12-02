require 'square'
require 'colors'
require 'move_possibility'

# An unoccupied square
class Empty < Square
  include Colors
  
  def square_view(on_white)
    piece_on_square(" ", false, on_white)
  end
  
  def is_move_possible(layout, from, to)
    MovePossibility.new(false, "Tried to move an empty square!")
  end
  
end