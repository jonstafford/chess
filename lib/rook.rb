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
    
    possible = true
    
    # Horrendous logic for figuring out if all the squares are empty between the
    # from and to
    if (from[0] == to[0]) # Move along a file
      sign = (to[1] - from[1]) / (to[1] - from[1]).abs
      i = from[1] + sign
      loop do
        break if i == to[1]
        possible &= layout[i][from[0]].empty?
        i += sign
      end    
    elsif (from[1] == to[1]) # Move along a row
      sign = (to[0] - from[0]) / (to[0] - from[0]).abs
      i = from[0] + sign
      loop do
        break if i == to[0]
        possible &= layout[from[1]][i].empty?
        i += sign
      end    
    else
      possible = false
    end

    MovePossibility.new(possible, possible ? nil : "Move not possible for rook")
  end
    
end