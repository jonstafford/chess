require_relative 'square'
require_relative 'colors'

class Piece < Square
  include Colors
    
  def initialize(white)
    @white = white
  end
  
  def square_view(on_white)
    piece_on_square(printable_char, white?, on_white)
  end
  
  def white?
    @white
  end
  
  def empty?
    false
  end
  
end