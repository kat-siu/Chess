require_relative 'piece'
require 'byebug'

class Board
  attr_reader :grid
  
  def initialize
    @grid = make_starting_grid
  end
  
  def make_starting_grid
    array = Array.new(8) { Array.new(8) }
    
    array.each_index do |row_idx|
      array[row_idx].each_index do |col_idx|
        case
        when [row_idx, col_idx] == [0,0] #black left rook
          array[row_idx][col_idx] = Rook.new([row_idx, col_idx], :b, false, self, "\u265C")
        when [row_idx, col_idx] == [0,1] #black left knight
          array[row_idx][col_idx] = Knight.new([row_idx, col_idx], :b, false, self, "\u265E")
        when [row_idx, col_idx] == [0,2] #black left bishop
          array[row_idx][col_idx] = Bishop.new([row_idx, col_idx], :b, false, self, "\u265D")
        when [row_idx, col_idx] == [0,3] #black Queen
          array[row_idx][col_idx] = Queen.new([row_idx, col_idx], :b, false, self, "\u265B")
        when [row_idx, col_idx] == [0,4] #black king
          array[row_idx][col_idx] = King.new([row_idx, col_idx], :b, false, self, "\u265A")
        when [row_idx, col_idx] == [0,5] #black right bishop
          array[row_idx][col_idx] = Bishop.new([row_idx, col_idx], :b, false, self, "\u265D")
        when [row_idx, col_idx] == [0,6] #black right knight
          array[row_idx][col_idx] = Knight.new([row_idx, col_idx], :b, false, self, "\u265E")
        when [row_idx, col_idx] == [0,7] #black right rook
          array[row_idx][col_idx] = Rook.new([row_idx, col_idx], :b, false, self, "\u265C")
        when row_idx == 1 #black pawn
          array[row_idx][col_idx] = Pawn.new([row_idx, col_idx], :b, false, self, "\u265F")
        when row_idx == 6 #white pawn
          array[row_idx][col_idx] = Pawn.new([row_idx, col_idx], :w, false, self, "\u2659")
        when [row_idx, col_idx] == [7,0] #black left rook
          array[row_idx][col_idx] = Rook.new([row_idx, col_idx], :w, false, self, "\u2656")
        when [row_idx, col_idx] == [7,1] #black left knight
          array[row_idx][col_idx] = Knight.new([row_idx, col_idx], :w, false, self, "\u2658")
        when [row_idx, col_idx] == [7,2] #black left bishop
          array[row_idx][col_idx] = Bishop.new([row_idx, col_idx], :w, false, self, "\u2657")
        when [row_idx, col_idx] == [7,3] #black Queen
          array[row_idx][col_idx] = Queen.new([row_idx, col_idx], :w, false, self, "\u2655")
        when [row_idx, col_idx] == [7,4] #black king
          array[row_idx][col_idx] = King.new([row_idx, col_idx], :w, false, self, "\u2654")
        when [row_idx, col_idx] == [7,5] #black right bishop
          array[row_idx][col_idx] = Bishop.new([row_idx, col_idx], :w, false, self, "\u2657")
        when [row_idx, col_idx] == [7,6] #black right knight
          array[row_idx][col_idx] = Knight.new([row_idx, col_idx], :w, false, self, "\u2658")
        when [row_idx, col_idx] == [7,7] #black right rook
          array[row_idx][col_idx] = Rook.new([row_idx, col_idx], :w, false, self, "\u2656")
        else
          array[row_idx][col_idx] = Piece.new([row_idx, col_idx], :n, true, self, :null)
        end
      end
    end
    
    #white
    array
  end
  
  #you don't have to use nested arrays for this method, though
  def move_piece(start_pos, end_pos)
    if self[start_pos].unicode == :null
      #debugger
      raise NoPieceHere.new("There isn't a piece at the starting position you selected")
    elsif self[start_pos].current_moves.include?(end_pos)
      self[end_pos] = self[start_pos]
      self[start_pos] = Piece.new([row_idx, col_idx], :n, true, self, :null)
    else
      raise InvalidMove.new("You cannot move your piece to the end position you selected")
    end
  end
  
  #requires user to use nested array in argument
  def [](pos)
    x, y = pos
  
    @grid[x][y]
  end
  
  #requires user to use nested array in argument
  def []=(pos, piece)
    x, y = pos
  
    @grid[x][y] = piece
  end
end

class NoPieceHere < StandardError; end
class InvalidMove < StandardError; end