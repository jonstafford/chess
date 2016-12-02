require 'move_syntax_validation'

describe MoveSyntaxValidation do
  
  describe "#initialize" do
    
    it "has an error for an invalid move" do
      
      validation = MoveSyntaxValidation.new("asdf")
      
      expect(validation.valid?).to be(false)
      
      expect(validation.error).to eql("'asdf' is not a valid move")
    end
 
    it "has an error for an invalid move" do
      
      validation = MoveSyntaxValidation.new("A8    b7 ")
      
      expect(validation.valid?).to be(true)
      
      expect(validation.syntactically_valid_move).to eql("a8b7")
    end
 
  end
  
end
      