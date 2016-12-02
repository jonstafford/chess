require_relative 'piece'

class Knight < Piece
  
  def self.char(white)
    if (white)
      # This may actually be the 'Black' unicode character, but whatever, it's the solid 
      # one, which we'll use as the White piece. 
      "\u265E" 
    else
      "\u2658"
    end
  end
  
  def printable_char
    Knight.char(white?)
  end
  
end