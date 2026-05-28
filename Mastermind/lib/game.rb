# frozen_string_literal: true

require_relative 'computer'
require_relative 'player'
require_relative 'display'

# Game handel's all the running of things and checks who the winner is
class Game
  attr_accessor :player1, :computer, :display

  def initialize
    self.display = Display.new
    self.player1 = Player.new
    self.computer = Computer.new
  end

  def win?(guess, code)
    return true if guess == code

    false
  end

  def green(g, guess, code, guess_copy, code_copy)
    guess.each_with_index do |value, index|
      next unless value == code[index]

      g += 1
      guess_copy[index] = nil
      code_copy[index] = nil
    end

    g
  end

  def white(w, guess_copy, code_copy)
    guess_copy.compact.each do |value|
      next unless code_copy.include?(value)

      w += 1
      code_copy[code_copy.index(value)] = nil
    end

    w
  end

  def evaluate_guess(guess, code)
    g = 0
    w = 0

    guess_copy = guess.clone
    code_copy = code.clone

    g = green(g, guess, code, guess_copy, code_copy)

    w = white(w, guess_copy, code_copy)

    [g, w]
  end

  def start
    choice = player1.play_choice
    if choice == 'no'
      robot_guessing
    elsif choice == 'yes'
      player_guessing
    end
  end

  def round_results(times, guess, code)
    display.guesses(times)

    g, w = evaluate_guess(guess, code)
    display.game_info(g, w, guess)

    [g, w]
  end

  def player_guessing
    code = computer.code_generator
    guess = player1.player_guess

    (1..12).each do |times|
      round_results(times, guess, code)

      return display.winner if win?(guess, code)

      guess = player1.player_guess
    end
    display.loser
  end

  def robot_guessing
    code = player1.player_code
    guess = computer.computer_guess

    (1..12).each do |times|
      g, w = round_results(times, guess, code)

      return display.loser if win?(guess, code)

      computer.filter_possible_codes(guess, [g, w], self)

      guess = computer.computer_guess
    end
    display.winner
  end
end
