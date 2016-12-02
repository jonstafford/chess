require 'square'
require 'colors'

class Piece < Square
  include Colors
  
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  def square_view(on_white)
    piece_on_square(printable_char, color, on_white)
  end
  
end