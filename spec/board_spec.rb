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
      (0..6).each do |row|
        expected = ""
        (0..7).each do |col|
          expected += piece_on_square(" ", false, !((row % 2 == 0) ^ (col % 2 == 0)))
        end
        expected_lines << expected
      end
      
      expected = ""
      expected += piece_on_square(Rook.char(true), true, false) # Bottom left square is dark
      expected += piece_on_square(Rook.char(true), true, true)
      expected += piece_on_square(Rook.char(false), false, false)
      expected += piece_on_square(Rook.char(false), false, true)
      expected += piece_on_square(" ", false, false)
      expected += piece_on_square(" ", false, true)
      expected += piece_on_square(" ", false, false)
      expected += piece_on_square(" ", false, true)
      
      expected_lines << expected
      
      expect(lines).to eql(expected_lines)
    end
  end
  
  
  
end
      