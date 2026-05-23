# frozen_string_literal: true

require_relative 'game'

# Checks if the players have tied or won
class Conditions
  attr_accessor :board

  def initialize(board)
    self.board = board
  end

  def tie?
    board.grid.all? { |row| row.all? { |cell| cell != '_' } }
  end

  def win?(player_turn)
    if board.grid.any? { |row| row.all? { |cell| cell == player_turn.character } } ||
       board.grid.transpose.any? { |col| col.all? { |cell| cell == player_turn.character } } ||
       (0..2).all? { |i| board.grid[i][i] == player_turn.character } ||
       (0..2).all? { |i| board.grid[i][2 - i] == player_turn.character }
      return true
    end

    false
  end
end
