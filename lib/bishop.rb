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
    
    diagonal_move =
    if (a1_h8_parallel)
      # Sum of distances from bottom edge and right edge is the same where
      # the two locations are on a diagonal parallel with a1-h8
      (7 - from[0]) + from[1] == (7 - to[0]) + to[1]
    else
      # Sum of distances from bottom edge and left edge is the same where
      # the two locations are on a diagonal with a8-h1
      from[0] + from[1] == to[0] + to[1]
    end    
    
    # Now check if there are pieces in the way
    piece_in_way = false
    if (diagonal_move)
      if (a1_h8_parallel)
        to_h8_direction = 
        if (to[0] > from[0])
          1
        else
          -1
        end
        x = from[0] + to_h8_direction
        y = from[1] + to_h8_direction
        loop do
          break if x == to[0]
          if (!layout[y][x].empty?)
            piece_in_way = true
            break
          end
          x = x + to_h8_direction
          y = y + to_h8_direction
        end
      else
        to_h1_direction =
        if (to[0] < from[0])
          1
        else
          -1
        end
        x = from[0] - to_h1_direction
        y = from[1] + to_h1_direction
        loop do
          break if x == to[0]
          if (!layout[y][x].empty?)
            piece_in_way = true
            break
          end
          x = x - to_h1_direction
          y = y + to_h1_direction
        end
      end      
    end
    
    possible = diagonal_move && !piece_in_way
    
    MovePossibility.new(possible, possible ? nil : "Move not possible for bishop")
  end
  
end