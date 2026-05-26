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
  attr_accessor :code

  def code_generator
    colors = %w[r y g p b m]

    colors.sample(4)
  end
end

class Player
  attr_accessor :guess

  def player_guess
    loop do
      print 'Guess: '

      colors = %w[r y g p b m]

      guess = gets.chomp.strip.split(',')

      if guess.any? { |char| colors.include?(char) } && guess.length == 4
        return guess
      else
        puts 'invalid input'
      end
    end
  end
end

class Game
  attr_accessor :board, :player1, :computer

  def initialize
    self.board = Board.new
    self.player1 = Player.new
    self.computer = Computer.new
  end

  def win?(guess, code)
    return true if guess == code

    false
  end

  def evaluate_guess(guess, code)
    g = 0
    w = 0

    guess.each_with_index do |value, index|
      next unless value == code[index]

      g += 1

      next if value != code[index]

      w += 1 if code.include?(value)
    end

    [g, w]
  end

  def start
    board.display
    board.select_color
    times_guessed = 1
    code = computer.code_generator

    (1..12).each do |_|
      puts "Times guessed: #{times_guessed}."
      times_guessed += 1
      puts code
      guess = player1.player_guess
      g, w  = evaluate_guess(guess, code)
      puts "Green #{g}"
      puts "White #{w}"
      puts guess

      if win?(guess, code)
        puts "You're now a chad"
        break
      end
    end
  end
end

def main
  game = Game.new
  game.start
end

main

# test: r,r,r,r
