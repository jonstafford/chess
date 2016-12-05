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
    possible = diagonal_move_possible?(layout, from, to)    
    
    MovePossibility.new(possible, possible ? nil : "Move not possible for bishop")
  end
  
end