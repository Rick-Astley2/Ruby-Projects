# frozen_string_literal: true

# handel's displaying winners, losers, info about the guess
class Display
  attr_accessor :g, :w, :guess

  def initialize
    self.g = g
    self.w = w
    self.guess = guess
  end

  def guesses(times)
    puts "Guess counter: #{times}"
  end

  def game_info(g, w, guess)
    puts "Green #{g}"
    puts "White #{w}"
    puts guess
  end

  def winner
    puts 'You won'
  end

  def loser
    puts "You've lost"
  end
end
