require 'colorize'
require 'byebug'
require_relative "piece"
require_relative 'board'
require_relative 'cursor'

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end
  
  
  def move_cursor
    key_return = true
    system("clear")
    render
    start_pos = nil
    end_pos = nil
    
    until key_return == false
      key_return = @cursor.get_input
      
      if @cursor.selected == true && start_pos == nil
        start_pos = @cursor.cursor_pos.dup
      elsif @cursor.selected == true && start_pos != nil
        end_pos = @cursor.cursor_pos.dup
      end
      
      system("clear")
      render
      
      if start_pos && end_pos
        begin
          @board.move_piece(start_pos, end_pos)
        rescue StandardError => error
          puts error.message
        end
        
        start_pos = nil
        end_pos = nil
      end
      
      #end of until loop
    end
    
    #end of move_cursor
  end
  
  
  def render
    @board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        if [row_idx, col_idx] == @cursor.cursor_pos && @cursor.selected == true
          print col.null == true ? " ".colorize(background: :green) : col.unicode.colorize(background: :green)
        elsif [row_idx, col_idx] == @cursor.cursor_pos && @cursor.selected == false
          print col.null == true ? " ".colorize(background: :red) : col.unicode.colorize(background: :red)
        elsif (row_idx.even? && col_idx.even?) || (row_idx.odd? && col_idx.odd?)
          print col.null == true ? " ".colorize(background: :cyan) : col.unicode.colorize(background: :cyan)
        else
          print col.null == true ? " " : col.unicode
        end
      end
      
      puts
    end
    
    nil
  end
end

Display.new(Board.new).move_cursor