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
  
  def is_move_possible(layout, from, to)
    
    straight_move = diagonal_move_possible?(layout, from, to) || row_or_file_move_possible?(layout, from, to)

    possible = false
    if (!straight_move)
      # Where it's not a straight move, it will be an 'L' shape when it's 
      # (1 + 2) or it's (2 + 1).
      possible = (to[0] - from[0]).abs + (to[1] - from[1]).abs == 3
    end

    MovePossibility.new(possible, possible ? nil : "Move not possible for Knight")
  end
  
end