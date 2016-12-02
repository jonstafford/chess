require 'bishop'

describe Bishop do
  
  describe "#is_move_possible" do
    
    it "must move in a straight diagonal line parallel to a8-h1" do
      
      builder = LayoutBuilder.new
      
      bishop = Bishop.new(true)
      builder.piece_at([0, 0], bishop)
      
      layout = builder.layout
      
      possibility = bishop.is_move_possible(layout, [0, 1], [1, 0])
      
      expect(possibility.possible?).to be(true)
    end
 
    it "must move in a straight diagonal line parallel to a1-h8" do
      
      builder = LayoutBuilder.new
      
      bishop = Bishop.new(true)
      builder.piece_at([6, 4], bishop)
      
      layout = builder.layout
      
      possibility = bishop.is_move_possible(layout, [6, 4], [3, 1])
      
      expect(possibility.possible?).to be(true)
    end
 
    it "must not allow an invalid move" do
      
      builder = LayoutBuilder.new
      
      bishop = Bishop.new(true)
      builder.piece_at([3, 3], bishop)
      
      layout = builder.layout
      
      possibility = bishop.is_move_possible(layout, [3, 3], [6, 7])
      
      expect(possibility.possible?).to be(false)
      expect(possibility.error).to eql("Invalid move")
    end
 
  end
  
end
      