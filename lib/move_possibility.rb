class MovePossibility
  
  attr_reader :error
  
  def initialize(possible, error=nil)
    @possible = possible
    @error = error
  end
  
  def possible?
    @possible
  end
end
  
  