class MoveSyntaxValidation
  
  attr_reader :error
  attr_reader :syntactically_valid_move
  
  def initialize(move_string)
    matches = move_string.match /\s*([a-hA-H][1-8])\s*([a-hA-H][1-8])\s*/
    @valid = !matches.nil?
    if (@valid)
      @syntactically_valid_move = (matches[1] + matches[2]).downcase
    else
      @error = "'#{move_string}' is not a valid move"
    end
  end
  
  def valid?
    @valid
  end
  
end
