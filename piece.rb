require_relative "board"

class Piece
  attr_reader :position, :color, :null, :unicode
  
  def initialize(position, color = :w, null = true, board, unicode)
    @position = position
    @color = color #black/white
    @null = null
    @board = board
    @moves = []
    @unicode = unicode
  end
  
  def valid_move?(board, end_pos)
    if @board[end_pos] == nil
      false 
    elsif @board[end_pos].color != @color
      true
    end
  end
end

module Stepping
  def current_moves
    current_moves = []
    
    @move_diffs.each do |move|
      potential_move = [@position[0] + move[0], @position[1] + move[1]]
      
      if valid_move?(@board, potential_move)
        current_moves << potential_move
      end
    end
  end
end

class Knight < Piece
  include Stepping
  
  def initialize(position, color = :w, null = true, board, unicode)
    super
    @move_diffs = [
      [1, 2], 
      [2, 1], 
      [-1, -2], 
      [-2, -1], 
      [1, -2], 
      [-1, 2], 
      [-2, 1], 
      [2, -1]
    ]
  end
  
end

class King < Piece
  include Stepping
  
  def initialize(position, color = :w, null = true, board, unicode)
    super
    
    @move_diffs = [
      [1, 0],
      [0, 1], 
      [-1, 0],
      [0, -1],
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ]
  end
end

module Sliding 
  DIAG_MOVES = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
  
  HORVERT_MOVES = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  
  def current_moves
    current_moves = []
    
    @directions.each do |move|
      moving = move
      
      until valid_move?(@board, potential_move)
        potential_move = [@position[0] + moving[0], @position[1] + moving[1]]
        
        if valid_move?(@board, potential_move)
          current_moves << potential_move
        end
        
        break if @board[potential_move].color != @color
        
        moving[0] += move[0]
        moving[1] += move[1]
      end
    end
  end
end

class Bishop < Piece
  include Sliding
  
  def initialize(position, color = :w, null = true, board, unicode)
    super
    @directions = DIAG_MOVES
  end
end

class Rook < Piece
  include Sliding
  
  def initialize(position, color = :w, null = true, board, unicode)
    super
    @directions = HORVERT_MOVES
  end
end

class Queen < Piece
  include Sliding

  def initialize(position, color = :w, null = true, board, unicode)
    super
    @directions = DIAG_MOVES + HORVERT_MOVES
  end
end

class Pawn < Piece
  def initialize(position, color = :w, null = true, board, unicode)
    super
    @opening_pos = position
    @moves = []
  end
end

# class Null < Piece
# end