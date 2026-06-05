# frozen_string_literal: true

# Gets the guess and whether the player wants to save
class Player
  def guess
    loop do
      char_guess = gets.chomp.strip.downcase

      return char_guess if char_guess == 'save'
      return char_guess if char_guess.length == 1 && char_guess.match?(/[a-z]/)

      puts 'Invalid input 1 letter.'
    end
  end
end
