module Colors
  
  def color_text(text, effect, background)
    bg =  ";" + background.to_s
   
    bright = ";1"
    
    "\e[#{effect}#{bg}#{bright}m#{text}\e[0m"
  end
  
  def piece_on_square(text, white, blue)
    effect =
    if (white)
      37
    else
      31
    end
    
    background =
    if (blue)
      44
    else
      40
    end
    
    color_text(text, effect, background)
  end
  
end

