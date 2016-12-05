require_relative 'square'
require_relative 'colors'

class Piece < Square
  include Colors
    
  def initialize(white)
    @white = white
  end
  
  def square_view(on_white)
    piece_on_square(printable_char, white?, on_white)
  end
  
  def white?
    @white
  end
  
  def empty?
    false
  end
  
  def row_or_file_move_possible?(layout, from, to)
    possible = true
    
    # Horrendous logic for figuring out if all the squares are empty between the
    # from and to
    if (from[0] == to[0]) # Move along a file
      sign = (to[1] - from[1]) / (to[1] - from[1]).abs
      i = from[1] + sign # Don't include the from[1] square itself
      loop do
        break if i == to[1]
        possible &= layout[i][from[0]].empty?
        i += sign
      end    
    elsif (from[1] == to[1]) # Move along a row
      sign = (to[0] - from[0]) / (to[0] - from[0]).abs
      i = from[0] + sign # Don't include the from[0] square itself
      loop do
        break if i == to[0]
        possible &= layout[from[1]][i].empty?
        i += sign
      end    
    else
      possible = false
    end
    
    possible
  end
  
  def diagonal_move_possible?(layout, from ,to)
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
    
    diagonal_move && !piece_in_way
  end
  
end