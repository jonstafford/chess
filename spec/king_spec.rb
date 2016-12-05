require 'king'

describe King do
  
  describe "#is_move_possible" do
    
    it "cannot move move than 1 square in any direction" do
      
      builder = LayoutBuilder.new
      
      king = King.new(true)
      builder.piece_at([4, 4], king)
     
      layout = builder.layout
     
      expect(king.is_move_possible(layout, [4, 4], [5, 5]).possible?).to be(true)
      expect(king.is_move_possible(layout, [4, 4], [3, 5]).possible?).to be(true)
      
      expect(king.is_move_possible(layout, [4, 4], [3, 2]).possible?).to be(false)
      expect(king.is_move_possible(layout, [4, 4], [4, 2]).possible?).to be(false)
      expect(king.is_move_possible(layout, [4, 4], [3, 6]).possible?).to be(false)
      expect(king.is_move_possible(layout, [4, 4], [4, 6]).possible?).to be(false)
      expect(king.is_move_possible(layout, [4, 4], [2, 4]).possible?).to be(false)
      expect(king.is_move_possible(layout, [4, 4], [6, 4]).possible?).to be(false)
      expect(king.is_move_possible(layout, [4, 4], [2, 3]).possible?).to be(false)
      expect(king.is_move_possible(layout, [4, 4], [6, 3]).possible?).to be(false)
    end 
 
  end
  
end
      