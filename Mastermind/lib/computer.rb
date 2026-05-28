# frozen_string_literal: true

# Computer gets the code for the player to guess and also guesses the player code
class Computer
  attr_accessor :code, :possible_codes

  def initialize
    self.possible_codes = all_codes
  end

  def code_generator
    colors = %w[r y g p b m]
    colors.sample(4)
  end

  def all_codes
    colors = %w[r y g p b m]
    colors.repeated_permutation(4).to_a
  end

  def computer_guess
    possible_codes.sample
  end

  def filter_possible_codes(last_guess, feedback, game)
    self.possible_codes = possible_codes.select do |code|
      game.evaluate_guess(last_guess, code) == feedback
    end
  end
end
