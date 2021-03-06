require 'board'
require 'game'
require 'colors'
require 'empty'
require 'layout_builder'

describe Board do
  
  describe "#board_view" do
    include Colors 
    
    it "answers the lines to output to the screen" do
      
      builder = LayoutBuilder.new
      
      builder.piece_at([0, 0], Rook.new(true))
      builder.piece_at([1, 0], Rook.new(true))
      builder.piece_at([2, 0], Rook.new(false))
      builder.piece_at([3, 0], Rook.new(false))
      
      board = Board.new(builder.layout)
      lines = board.board_view
      
      expected_lines = []
      expected_lines << ""
      
      (0..6).each do |row|
        expected = (8 - row).to_s + "  "
        (0..7).each do |col|
          expected += piece_on_square(" ", false, !((row % 2 == 0) ^ (col % 2 == 0)))
        end
        expected_lines << expected
      end
      
      expected = "1  "
      expected += piece_on_square(Rook.char(true), true, false) # Bottom left square is dark
      expected += piece_on_square(Rook.char(true), true, true)
      expected += piece_on_square(Rook.char(false), false, false)
      expected += piece_on_square(Rook.char(false), false, true)
      expected += piece_on_square(" ", false, false)
      expected += piece_on_square(" ", false, true)
      expected += piece_on_square(" ", false, false)
      expected += piece_on_square(" ", false, true)
      
      expected_lines << expected
      
      expected_lines << ""
      expected_lines << "   " + "abcdefgh"
      expected_lines << ""      
      
      # For debugging
      #expected_lines.each {|l| puts l }
      #lines.each {|l| puts l }
      
      expect(lines).to eql(expected_lines)
    end
  end
  
  describe "#move_piece" do
    
    it "moves a piece from one place to another" do
      
      expected_builder = LayoutBuilder.new
      expected_builder.piece_at([2, 0], Rook.new(false))
      expected_board = Board.new(expected_builder.layout)
      expected_lines = expected_board.board_view
      
      builder = LayoutBuilder.new
      builder.piece_at([6, 0], Rook.new(false))
      board = Board.new(builder.layout)
      
      board.move_piece([6, 0], [2, 0])
      
      lines = board.board_view

      # For debugging
      #expected_lines.each {|l| puts l }
      #lines.each {|l| puts l }

      expect(lines).to eql(expected_lines)
    end
    
    it "black rook captures white rook" do
      
      expected_builder = LayoutBuilder.new
      expected_builder.piece_at([1, 5], Rook.new(false))
      expected_board = Board.new(expected_builder.layout)
      expected_lines = expected_board.board_view
      
      builder = LayoutBuilder.new
      builder.piece_at([1, 1], Rook.new(false))
      builder.piece_at([1, 5], Rook.new(true))
      board = Board.new(builder.layout)
      
      board.move_piece([1, 1], [1, 5])
      
      lines = board.board_view

      # For debugging
      #expected_lines.each {|l| puts l }
      #lines.each {|l| puts l }

      expect(lines).to eql(expected_lines)
    end
  end
  
  it "recognizes being in check" do
    builder = LayoutBuilder.new
    
    builder.piece_at([4, 4], Knight.new(false))
    builder.piece_at([5, 6], King.new(true))
    builder.piece_at([1, 1], King.new(false))
   
    layout = builder.layout
    
    board = Board.new(layout)
    
    expect(board.in_check?(true)).to be(true)
    expect(board.in_check?(false)).to be(false)
  end

  it "recognizes a move which would leave the player in check" do
    builder = LayoutBuilder.new
    
    builder.piece_at([4, 4], Knight.new(false))
    builder.piece_at([5, 5], King.new(true))
   
    layout = builder.layout
    
    board = Board.new(layout)
    
    expect(board.move_leaves_player_in_check?(true, [5, 5], [5, 6])).to be(true)
  end
  
  
  it "can calculate if there is a move to not be in check" do
    builder = LayoutBuilder.new
    
    builder.piece_at([0, 4], Rook.new(false))
    builder.piece_at([0, 6], Rook.new(false))
    builder.piece_at([4, 2], Rook.new(false))
    builder.piece_at([6, 2], Rook.new(false))
    builder.piece_at([5, 5], King.new(true))
    builder.piece_at([4, 1], Pawn.new(true))
    builder.piece_at([6, 1], Pawn.new(true))
   
    layout = builder.layout
    
    board = Board.new(layout)
    
    expect(board.has_move_so_not_in_check?(true)).to be(false)
  end
  
  
end
      