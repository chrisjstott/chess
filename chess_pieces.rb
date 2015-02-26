require_relative 'chess_board.rb'

class Piece
  attr_reader :color, :location, :board, :move_dirs

  def initialize(color, location, board)
    @color = color
    @location = location
    @board = board
  end

  def inspect
    "#{self.class}: #{self.color}"
  end

  def opponent_color
    color == :white ? :black : :white
  end

end

class SlidingPiece < Piece

  def moves
    moves = []
    self.move_dirs.each do |dir|
      x, y = location[0], location[1]
      x_move, y_move = dir[0], dir[1]
      new_position = [x + x_move, y + y_move]
      # need to define occupied? in board class
      until board.occupied?(new_position) || board.off_board?(new_position)
        moves << new_position
        new_position[0] += x_move
        new_position[1] += y_move
      end
      if board.occupied?(new_position)
        piece_in_way = board.grid[new_position]
        moves << new_position if piece_in_way.color == opponent_color
      end
    end
    moves
  end

end

class SteppingPiece < Piece

  def moves
    moves = []
    self.move_dirs.each do |dir|
      if board.occupied?(new_position)
        piece_in_way = board.grid[new_position]
        moves << new_position if piece_in_way.color == opponent_color
      elsif !board(new_position).occupied? && !board(new_position).off_board?
        moves << new_position
      end
    end
    moves
  end

end

class Rook < SlidingPiece

  def initialize(color, location, board)
    super
    @move_dirs = [[-1, 0],[1, 0],[0, 1],[0, -1]]
  end

end

class Queen < SlidingPiece

  def intialize(color, location, board)
    super
    @move_dirs = [[-1, 0], [1, 0], [0, 1], [0, -1],
                  [-1, 1], [1, -1], [1, 1], [-1, -1]]
  end

end

class Bishop < SlidingPiece

  def intialize(color, location, board)
    super
    @move_dirs = [[-1, 1], [1, -1], [1, 1], [-1, -1]]
  end

end

class Knight < SteppingPiece

  def intialize(color, location, board)
    super
    @move_dirs = [[-1, 2], [1, -2], [1, 2], [-1, -2],
                  [-2, 1], [2, -1], [2, 1], [-2, -1]]
  end

end

class King < SteppingPiece

  def intialize(color, location, board)
    super
    @move_dirs = [[-1, 0], [1, 0], [0, 1], [0, -1],
                  [-1, 1], [1, -1], [1, 1], [-1, -1]]
  end

end

class Pawn < Piece

end
