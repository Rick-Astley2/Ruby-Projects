# frozen_string_literal: true
class Display
  
end

class Player
  def guess
    loop do
      char_guess = gets.chomp.strip.downcase

      return char_guess if char_guess.length == 1 && char_guess.match?(/[a-z]/)

      puts 'Invalid input 1 letter.'
    end
  end
end
class Computer
  def word
    full_word_list = File.open 'google-10000-english-no-swears.txt', 'r'

    word_list = []

    full_word_list.each { |line| word_list << line if line.length.between?(5, 12) }

    puts word_list.sample
  end
end
class Game
  attr_accessor :computer, :player

  def initialize
    self.computer = Computer.new
    self.player = Player.new
  end

  def start
    computer.word
    player.guess
  end
end

def main
  game = Game.new
  game.start
end

main
