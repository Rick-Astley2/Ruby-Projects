# frozen_string_literal: true
class Display
  attr_accessor :num

  def initialize
    self.num = num
  end

  def create_string(num)
    string = Array.new(num) { '_' }

    puts string.join(' ')
  end
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

    word_list.sample
  end
end
class Game
  attr_accessor :computer, :player, :display, :used_letters

  def initialize
    self.computer = Computer.new
    self.player = Player.new
    self.display = Display.new
    self.used_letters = []
  end

  def check_guess?(word, guess)
    char_list = word.chars
    puts char_list
    return false if used_letters.include?(guess)

    if char_list.any? { |char| char == guess }
      used_letters << guess
      return true
    end

    used_letters << guess
    false
  end

  def start
    word = computer.word
    loop do
      display.create_string(word.length)
      guess = player.guess
      puts check_guess?(word, guess)
    end
  end
end

def main
  game = Game.new
  game.start
end

main
