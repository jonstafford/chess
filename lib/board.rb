require_relative 'colors'
require_relative 'move_syntax_validation'
require_relative 'king'

class Board
  include Colors
  
  attr_reader :layout
  
  def initialize(layout)
    # @layout is an array of row arrays. So location [x, y] is at @layout[y][x].
    @layout = layout
  end
  
  # Answers an array of lines which can be printed to the console to display 
  # the board.
  def board_view
    lines = []
    
    count = 0
    @layout.each_with_index do |row, y|
      l = (y + 1).to_s + "  "
      row.each do |square|
        count += 1
        l += square.square_view(count % 2 == 0)
      end
      count += 1 # Because next row begins with the same color as last row ends
      lines.unshift(l)
    end
    
    lines.unshift("") # Blank line before
    
    lines << ""
    lines << "   " + "abcdefgh"
    lines << "" # Blank line after
    
    lines 
  end
  
  def move_piece(from, to)
    @layout[to[1]][to[0]] =  @layout[from[1]][from[0]]
    @layout[from[1]][from[0]] = Empty.new
  end
  
  def set_piece(location, piece)
    @layout[location[1]][location[0]] = piece
  end
  
  def undo_move_piece(old_from, old_from_piece, old_to, old_to_piece)
    set_piece(old_from, old_from_piece)
    set_piece(old_to, old_to_piece)
  end
  
  def piece_at_location(location)
    @layout[location[1]][location[0]]
  end

  # Answers hash of the pieces of the color given
  def pieces(white, only_king=false)
    result = {}
    @layout.each_with_index do |row, y|
      row.each_with_index do |square, x|
        if (!square.empty? && square.white? == white && (!only_king || square.is_a?(King)))
          result[[x, y]] = square
        end
      end
    end
    result    
  end

  def in_check?(player_is_white)
    player_king_location = pieces(player_is_white, true).keys[0]
    
    other_player_pieces = pieces(!player_is_white)

    other_player_pieces.each do |location, piece|
      if (piece.is_move_possible(layout, location, player_king_location).possible?)
        return true
      end
    end    
 
    return false
  end

end