require 'knight'

describe Knight do
  
  describe "#is_move_possible" do
    
    it "moves in an 'L' shape" do
      
      builder = LayoutBuilder.new
      
      knight = Knight.new(true)
      builder.piece_at([4, 4], knight)
     
      layout = builder.layout

      # Cannot move to 8 squares surrounding it

      expect(knight.is_move_possible(layout, [4, 4], [5, 3]).possible?).to be(false)
      expect(knight.is_move_possible(layout, [4, 4], [5, 4]).possible?).to be(false)
      expect(knight.is_move_possible(layout, [4, 4], [5, 5]).possible?).to be(false)

      expect(knight.is_move_possible(layout, [4, 4], [4, 3]).possible?).to be(false)
      expect(knight.is_move_possible(layout, [4, 4], [4, 5]).possible?).to be(false)

      expect(knight.is_move_possible(layout, [4, 4], [3, 3]).possible?).to be(false)
      expect(knight.is_move_possible(layout, [4, 4], [3, 4]).possible?).to be(false)
      expect(knight.is_move_possible(layout, [4, 4], [3, 5]).possible?).to be(false)
     
      # Cannot move to a square in a straight line 2 squares away
      expect(knight.is_move_possible(layout, [4, 4], [6, 4]).possible?).to be(false) # Row
      expect(knight.is_move_possible(layout, [4, 4], [2, 2]).possible?).to be(false) # Diagonal
      
      # Can move in 'L' shape
      expect(knight.is_move_possible(layout, [4, 4], [6, 5]).possible?).to be(true)
      expect(knight.is_move_possible(layout, [4, 4], [6, 3]).possible?).to be(true)
      expect(knight.is_move_possible(layout, [4, 4], [2, 5]).possible?).to be(true)
      expect(knight.is_move_possible(layout, [4, 4], [2, 3]).possible?).to be(true)
      expect(knight.is_move_possible(layout, [4, 4], [5, 6]).possible?).to be(true)
      expect(knight.is_move_possible(layout, [4, 4], [3, 6]).possible?).to be(true)
      expect(knight.is_move_possible(layout, [4, 4], [5, 2]).possible?).to be(true)
      expect(knight.is_move_possible(layout, [4, 4], [3, 2]).possible?).to be(true)
    end 
 
  end
  
end
      