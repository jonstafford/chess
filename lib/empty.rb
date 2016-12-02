require 'square'
require 'colors'

# An unoccupied square
class Empty < Square
  include Colors
  
  def square_view(on_white)
    piece_on_square(" ", false, on_white)
  end
  
end