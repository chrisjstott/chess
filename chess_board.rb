require_relative 'chess_pieces.rb'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    new_piece_setup
  end

  def new_piece_setup
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    # try to create a helper method
    (0..7).each do |column|
      grid[0][column] = back_row[column].new(:black, [0, column], self)
    end

    (0..7).each do |column|
      grid[1][column] = Pawn.new(:black, [1, column], self)
    end

    (0..7).each do |column|
      grid[6][column] = Pawn.new(:white, [6, column], self)
    end

    (0..7).each do |column|
      grid[7][column] = back_row[column].new(:white, [7, column], self)
    end
  end

  def opposite_color(color)
    color == :white ? :black : :white
  end

  def in_check?(color)
    opponent_pieces = find_team(opposite_color(color))
    my_king = find_king(color)
    opponent_pieces.each do |piece|
      return true if piece.moves.include?(my_king.location)
    end
    false
  end

  def find_team(color)

  end

  def find_king(color)

  end

  def occupied?(location)
    x = location[0]
    y = location[1]
    return true unless board[x][y].nil?
    false
  end

  def off_board?(location)
    return true if location[0].between?(0,7) && location[1].between?(0,7)
    false
  end

end
