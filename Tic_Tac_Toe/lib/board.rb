# frozen_string_literal: true

# Creates the board
class Board
  attr_accessor :grid

  def initialize
    self.grid = Array.new(3) { Array.new(3) { '_' } }
  end

  def display
    grid.map { |row| row.join(' ') }.each { |row| puts row }
  end
end
