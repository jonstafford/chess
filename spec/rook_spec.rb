require 'rook'

describe Rook do
  
  describe "#is_move_possible" do
    
    it "moves along rows" do
      
      builder = LayoutBuilder.new
      
      rook = Rook.new(true)
      builder.piece_at([0, 1], rook)
      
      layout = builder.layout
      
      possibility = rook.is_move_possible(layout, [0, 1], [0, 5])
      
      expect(possibility.possible?).to be(true)
    end
 
    it "moves along files" do
      
      builder = LayoutBuilder.new
      
      rook = Rook.new(true)
      builder.piece_at([6, 4], rook)
      
      layout = builder.layout
      
      possibility = rook.is_move_possible(layout, [6, 4], [2, 4])
      
      expect(possibility.possible?).to be(true)
    end
 
    it "must not allow an invalid move" do
      
      builder = LayoutBuilder.new
      
      rook = Rook.new(true)
      builder.piece_at([3, 3], rook)
      
      layout = builder.layout
      
      possibility = rook.is_move_possible(layout, [3, 3], [4, 4])
      
      expect(possibility.possible?).to be(false)
      expect(possibility.error).to eql("Move not possible for rook")
    end
    
    it "a move which would jump other pieces is invalid" do
      
      builder = LayoutBuilder.new
      
      rook = Rook.new(true)
      builder.piece_at([2, 2], rook)
      builder.piece_at([2, 5], Bishop.new(true))
      
      layout = builder.layout
      
      possibility = rook.is_move_possible(layout, [2, 2], [2, 6])
      
      expect(possibility.possible?).to be(false)
      expect(possibility.error).to eql("Move not possible for rook")
    end
  end
  
end
      