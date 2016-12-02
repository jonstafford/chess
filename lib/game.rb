require './lib/board'
require './lib/rook'
require './lib/knight'
require './lib/bishop'
require './lib/queen'
require './lib/king'
require './lib/pawn'

class Game
  
  
  def self.initial_piece_row(color)
    row = []
    row << Rook.new(color)
    row << Knight.new(color)
    row << Bishop.new(color)
    row << Queen.new(color)
    row << King.new(color)
    row << Bishop.new(color)
    row << Knight.new(color)
    row << Rook.new(color)
    row
  end
  
  def self.initial_pawn_row(color)
    row = []
    8.times { row << Pawn.new(color) }
    row
  end
  
  def self.starting_layout
    layout = []
    
    layout << initial_piece_row(true)
    layout << initial_pawn_row(true)    
    
    4.times do
      empty_row = []
      8.times { empty_row << :e }
      layout << empty_row
    end
    
    layout << initial_pawn_row(false)    
    layout << initial_piece_row(false)
    
    layout
  end
  
  def initialize     
    @board = Board.new(starting_layout)
  end
  
  def get_move
    move = gets.chomp
  end
  
  def print_board
    view = @board.board_view
    view.each do |l|
      puts l
    end
    
    puts @board.board_status
  end
  
  def play_game
    loop do
      print_board
      move = get_move
      @board.play_move(move)
      break if @board.done?
    end
    print_board
  end
  
end