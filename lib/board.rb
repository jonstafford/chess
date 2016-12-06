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

  def move_leaves_player_in_check?(player_is_white, from, to)
    from_piece = piece_at_location(from)
    to_piece = piece_at_location(to)
    move_piece(from, to)
    result = in_check?(player_is_white)
    undo_move_piece(from, from_piece, to, to_piece)
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

  def has_move_so_not_in_check?(player_is_white)
    pieces = pieces(player_is_white)
    
    pieces.each do |location, piece|
      @layout.each_with_index do |row, y|
        row.each_with_index do |square, x|
          to = [x, y]
          return true if (move_possible(player_is_white, location, to).nil? &&
            !move_leaves_player_in_check?(player_is_white, location, to))
        end
      end
    end
    
    return false
  end
  
  def move_possible(player_is_white, from, to)
    piece = piece_at_location(from)
    target_piece = piece_at_location(to)
    
    error = nil
    if (from == to)
      error = "Start location is same as target location"
    elsif (piece.empty? || piece.white? != player_is_white)
      error = "Start location is not one of your pieces!"
    elsif (!target_piece.empty? && target_piece.white? == player_is_white)
      error = "Target location already has one of your pieces!"
    else
        
      possibility = piece.is_move_possible(layout, from, to)
    
      if (possibility.possible?)
        # The move shouldn't put the player into check or fail to get them 
        # out of check if they already are in check.
        if (move_leaves_player_in_check?(player_is_white, from, to)) 
          error = "That move would leave the " + (player_is_white ? "white" : "black") + " player in check."
        end
      else
        error = possibility.error
      end
    end
    
    error
  end

end