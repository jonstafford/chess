require_relative 'piece'

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
    Bishop.char(white?)
  end
  
  def is_move_possible(layout, from, to)
    
    # Establish if the diagonal move is in the a1-h8 direction
    a1_h8_parallel = (from[0] - to[0]) * (from[1] - to[1]) > 0
    
    possible =
    if (a1_h8_parallel)
      # Sum of distances from bottom edge and right edge is the same where
      # the two locations are on a diagonal parallel with a1-h8
      (7 - from[0]) + from[1] == (7 - to[0]) + to[1]
    else
      # Sum of distances from bottom edge and left edge is the same where
      # the two locations are on a diagonal with a8-h1
      from[0] + from[1] == to[0] + to[1]
    end    
    
    MovePossibility.new(possible, possible ? nil : "Move not possible for bishop")
  end
  
end