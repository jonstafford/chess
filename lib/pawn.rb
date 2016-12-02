require './lib/piece'

class Pawn < Piece
  
  def self.char(white)
    if (white)
      # This may actually be the 'Black' unicode character, but whatever, it's the solid 
      # one, which we'll use as the White piece. 
      "\u265F" 
    else
      "\u2659"
    end
  end
  
  def printable_char
    Pawn.char(white?)
  end
  
end