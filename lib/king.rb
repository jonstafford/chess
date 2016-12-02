require './lib/piece'

class King < Piece
  
  def self.char(white)
    if (white)
      # This may actually be the 'Black' unicode character, but whatever, it's the solid 
      # one, which we'll use as the White piece. 
      "\u265A" 
    else
      "\u2654"
    end
  end
  
  
  def printable_char
    King.char(white?)
  end
  
end
