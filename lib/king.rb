require_relative 'piece'

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
  
  def is_move_possible(layout, from, to)
    
    possible = ((to[0] - from[0]).abs <= 1) && ((to[1] - from[1]).abs <= 1)

    MovePossibility.new(possible, possible ? nil : "Move not possible for King")
  end
  
end
