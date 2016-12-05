require_relative 'piece'

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
  
  def is_move_possible(layout, from, to)
    
    direction = white? ? 1 : -1
        
    location_in_front = [from[0], from[1] + direction]
    square_in_front = layout[location_in_front[1]][location_in_front[0]]
    
    possible = false
    if square_in_front.empty?
      if (to == location_in_front)
        possible = true
      else
        still_in_starting_location =
        if (white?)
          from[1] == 1
        else
          from[1] == 6
        end
        
        if (still_in_starting_location)
          location_2_in_front = [from[0], from[1] + 2 * direction]
          
          if (location_2_in_front == to)  
            square_2_in_front = layout[location_2_in_front[1]][location_2_in_front[0]]
            possible = square_2_in_front.empty?
          end
        end
      end
    end
    
    if (!possible)
      
      # Consider whether there's a piece of the opposite color that could be
      # captured diagonally in front of the pawn.
      
      location_left = nil
      if (from[0] > 0) # Not in file 'a'
        location_left = [from[0] - 1, from[1] + direction]
      end
      
      location_right = nil
      if (from[0] < 7) # Not in file 'h'
        location_right = [from[0] + 1, from[1] + direction]
      end
      
      if (to == location_left || to == location_right)        
        square = layout[to[1]][to[0]]
        possible = !square.empty? && (white? ^ square.white?)
      end
    end
       
    MovePossibility.new(possible, possible ? nil : "Move not possible for pawn")
  end
  
end