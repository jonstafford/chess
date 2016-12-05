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
       
    MovePossibility.new(possible, "Move not possible for pawn")
  end
  
end