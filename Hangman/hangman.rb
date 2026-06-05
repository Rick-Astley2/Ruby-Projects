# frozen_string_literal: true

require 'yaml'
class Display
  attr_accessor :num

  def create_word_bar(num)
    Array.new(num) { '_' }
  end
end

class Player
  def guess
    loop do
      char_guess = gets.chomp.strip.downcase

      return input if input == 'save'
      return char_guess if char_guess.length == 1 && char_guess.match?(/[a-z]/)

      puts 'Invalid input 1 letter.'
    end
  end
end
class Computer
  def word
    full_word_list = File.open 'google-10000-english-no-swears.txt', 'r'

    word_list = []

    full_word_list.each do |line|
      line = line.chomp
      word_list << line if line.length.between?(5, 12)
    end

    word_list.sample
  end
end
class Game
  attr_accessor :computer, :player, :display, :used_letters, :guess_count, :word, :word_bar

  def initialize
    self.computer = Computer.new
    self.player = Player.new
    self.display = Display.new
    self.used_letters = []
    self.guess_count = 0
  end

  def save_game
    data = {
      word: word,
      word_bar: word_bar,
      used_letters: used_letters,
      guess_count: guess_count
    }
    File.write('file_name.yml', YAML.dump(data))
    puts 'Saved'
  end

  def load_game
    return false unless File.exist?('file_name.yml')

    data = YAML.load_file('file_name.yml')

    self.word = data[:word]
    self.word_bar = data[:word_bar]
    self.used_letters = data[:used_letters]
    self.guess_count = data[:guess_count]

    true
  end

  def check_guess?(word, guess, word_bar)
    char_list = word.chars
    if char_list.include?(guess)
      char_list.each_with_index do |letter, index|
        word_bar[index] = guess if letter == guess
      end
    elsif !used_letters.include?(guess)
      self.guess_count += 1
    end

    used_letters << guess unless used_letters.include?(guess)
    word_bar.all? { |char| char != '_' }
  end

  def start
    word = computer.word
    word_bar = display.create_word_bar(word.length)
    while guess_count < 6
      puts "Misses: #{guess_count}"
      puts word_bar.join(' ')
      guess = player.guess
      puts used_letters.join(' ')
      if check_guess?(word, guess, word_bar)
        puts 'you won'
        break
      end
    end
    puts "The word was #{word}"
  end
end

def main
  game = Game.new
  game.start
end

main
