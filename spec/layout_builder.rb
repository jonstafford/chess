# Spec helper factory class for constructing board layouts.
# Specify the location of any pieces with `piece_at`. 
# `#layout` answers the 8x8 board array with pieces as specified and all other
# spaces with an Empty square.
class LayoutBuilder
  
  def initialize
    @pieces = {}
  end 
   
  def piece_at(location, piece)
    @pieces[location] = piece
  end
  
  def layout
    layout = []
    
    8.times do |y| 
      row = []
      
      8.times do |x|
        
        piece = @pieces[[x, y]]
        if piece.nil?
          row << Empty.new
        else
          row << piece
        end
      end
      
      layout << row
    end
    
    layout
  end
  
end
