require 'pawn'

describe Pawn do
  
  describe "#is_move_possible" do
    
    it "can move one or two squares forward on the first move" do
      
      builder = LayoutBuilder.new
      
      white_pawn = Pawn.new(true)
      builder.piece_at([0, 1], white_pawn)
      black_pawn = Pawn.new(false)
      builder.piece_at([0, 6], black_pawn)
      
      layout = builder.layout
      
      # Move forward 1 square
      expect(white_pawn.is_move_possible(layout, [0, 1], [0, 2]).possible?).to be(true)
      # Move forward 2 squares
      expect(white_pawn.is_move_possible(layout, [0, 1], [0, 3]).possible?).to be(true)
      # Move forward 1 square
      expect(black_pawn.is_move_possible(layout, [0, 6], [0, 5]).possible?).to be(true)
      # Move forward 2 squares
      expect(black_pawn.is_move_possible(layout, [0, 6], [0, 4]).possible?).to be(true)
    end 
 
    it "cannot move to squares that aren't immediately in front of it" do
      
      builder = LayoutBuilder.new
      
      pawn = Pawn.new(true)
      builder.piece_at([0, 1], pawn)
      
      layout = builder.layout
     
      possibility = pawn.is_move_possible(layout, [0, 1], [1, 1])
      
      expect(possibility.possible?).to be(false)
      expect(possibility.error).to eql("Move not possible for pawn")
    end
 
  end
  
end
      