# frozen_string_literal: true

require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    self.grid = Array.new(12) { Array.new(4) { '_' } } 
  end

  def display
    grid.map { |row| row.join(' ') }.each { |row| puts row }
  end

  def select_color
    colors = ['•'.red, '•'.yellow, '•'.green, '•'.light_magenta, '•'.blue, '•'.magenta]
    puts colors.join(' ')
  end
end

class Computer
end

class Player
end

class Game
  attr_accessor :board

  def initialize
    self.board = Board.new
  end

  def start
    board.display
    board.select_color
  end
end

def main
  game = Game.new
  game.start
end

main
