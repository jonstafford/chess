require_relative 'piece'

class Rook < Piece
  
  def self.char(white)
    if (white)
      # This may actually be 'Black Chess Rook', but whatever, it's the solid 
      # one, which we'll use as the White piece. 
      "\u265C" 
    else
      "\u2656"
    end
  end
  
  def printable_char
    Rook.char(white?)
  end
  
  def is_move_possible(layout, from, to)
    
    # TODO 

    MovePossibility.new(true, nil)
  end
    
end