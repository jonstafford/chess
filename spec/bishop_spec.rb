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
 
    it "must not allow a move not along a diagonal" do
      
      builder = LayoutBuilder.new
      
      bishop = Bishop.new(true)
      builder.piece_at([3, 3], bishop)
      
      layout = builder.layout
      
      possibility = bishop.is_move_possible(layout, [3, 3], [6, 7])
      
      expect(possibility.possible?).to be(false)
      expect(possibility.error).to eql("Move not possible for bishop")
    end
 
    it "must not allow a move where other pieces are in the way" do
      
      builder = LayoutBuilder.new
      
      bishop = Bishop.new(true)
      builder.piece_at([3, 3], bishop)
      builder.piece_at([4, 4], Rook.new(true))
      
      layout = builder.layout
      
      possibility = bishop.is_move_possible(layout, [3, 3], [6, 6])
      
      expect(possibility.possible?).to be(false)
      expect(possibility.error).to eql("Move not possible for bishop")
    end 
 
  end
  
end
      