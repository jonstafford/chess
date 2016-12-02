require 'board'
require 'game'
require 'colors'
require 'empty'

describe Board do
  
  describe "#board_view" do
    include Colors 
    
    it "answers the lines to output to the screen" do
      
      layout = []
      row = []
      row << Rook.new(true)
      row << Rook.new(true)
      row << Rook.new(false)
      row << Rook.new(false)
      row << Empty.new
      row << Empty.new
      row << Empty.new
      row << Empty.new
      layout << row
      
      board = Board.new(layout)
      lines = board.board_view
      
      expected = ""
      expected += piece_on_square(Rook.char(true), true, false) # Bottom left square is dark
      expected += piece_on_square(Rook.char(true), true, true)
      expected += piece_on_square(Rook.char(false), false, false)
      expected += piece_on_square(Rook.char(false), false, true)
      expected += piece_on_square(" ", false, false)
      expected += piece_on_square(" ", false, true)
      expected += piece_on_square(" ", false, false)
      expected += piece_on_square(" ", false, true)
      
      expected_lines = []
      expected_lines << expected
      
      expect(lines).to eql(expected_lines)
    end
  end
  
  
  
end
      