# frozen_string_literal: true

require 'yaml'
require_relative 'player'
require_relative 'game'
require_relative 'display'

# Handles starting, loading, and saving the game
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
    File.write('hang_man_save.yml', YAML.dump(data))
    puts 'Saved'
  end

  def load_game
    return false unless File.exist?('hang_man_save.yml')

    data = YAML.load_file('hang_man_save.yml')

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
    unless load_game
      self.word = computer.word
      self.word_bar = display.create_word_bar(word.length)
    end

    while guess_count < 6
      puts "Misses: #{guess_count}"
      puts word_bar.join(' ')
      puts used_letters.join(' ')

      guess = player.guess
      if guess == 'save'
        save_game
        return
      end
      next unless check_guess?(word, guess, word_bar)

      puts 'you won'
      File.delete('hang_man_save.yml') if File.exist?('hang_man_save.yml')
      break
    end

    puts "The word was #{word}"
    File.delete('hang_man_save.yml') if File.exist?('hang_man_save.yml')
  end
end
