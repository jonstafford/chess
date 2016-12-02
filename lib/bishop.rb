require './lib/piece'

class Bishop < Piece
  
  def self.char(white)
    if (white)
      # This may actually be the 'Black' unicode character, but whatever, it's the solid 
      # one, which we'll use as the White piece. 
      "\u265D" 
    else
      "\u2657"
    end
  end
  
  def printable_char
    Bishop.char(color)
  end
  
end