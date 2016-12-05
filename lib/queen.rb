require_relative 'piece'

class Queen < Piece
  
  def self.char(white)
    if (white)
      # This may actually be the 'Black' unicode character, but whatever, it's the solid 
      # one, which we'll use as the White piece. 
      "\u265B" 
    else
      "\u2655"
    end
  end
    
  def printable_char
    Queen.char(white?)
  end
  
  def is_move_possible(layout, from, to)
    
    possible = diagonal_move_possible?(layout, from, to) || row_or_file_move_possible?(layout, from, to)

    MovePossibility.new(possible, possible ? nil : "Move not possible for Queen")
  end
    
end