# frozen_string_literal: true

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

class Player
  attr_accessor :guess, :code

  def player_guess
    print 'Guess: '
    prompt_player
  end

  def prompt_player
    loop do
      colors = %w[r y g p b m]

      input = gets.chomp.strip.split(',')

      return input if input.all? { |char| colors.include?(char) } && input.length == 4

      puts 'invalid input'
    end
  end

  def play_choice
    loop do
      print 'Would you like the computer to pick the code or you? '
      choice = gets.chomp.strip.to_s

      return choice if %w[computer me].include?(choice)

      puts 'Invalid input please type computer or me.'
    end
  end

  def player_code
    print 'Create a code: '
    prompt_player
  end
end

class Game
  attr_accessor :player1, :computer

  def initialize
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

    guess_copy = guess.clone
    code_copy = code.clone

    guess.each_with_index do |value, index|
      next unless value == code[index]

      g += 1
      guess_copy[index] = nil
      code_copy[index] = nil
    end

    guess_copy.compact.each do |value|
      next unless code_copy.include?(value)

      w += 1
      code_copy[code_copy.index(value)] = nil
    end


    [g, w]
  end

  def start
    choice = player1.play_choice
    if choice == 'computer'
      robot_guessing
    elsif choice == 'me'
      player_guessing
    end
  end

  def player_guessing
    times_guessed = 1
    code = computer.code_generator

    (1..12).each do |_|
      puts "Times guessed: #{times_guessed}."
      times_guessed += 1
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

  def robot_guessing
    code = player1.player_code
    guess = computer.computer_guess

    (1..12).each do |times|
      puts "Times guessed: #{times + 1}."

      g, w = evaluate_guess(guess, code)
      puts "Green #{g}"
      puts "White #{w}"
      puts guess

      return puts 'You lose' if win?(guess, code)

      computer.filter_possible_codes(guess, [g, w], self)

      guess = computer.computer_guess
    end
    puts 'You won'
  end
end

def main
  game = Game.new
  game.start
end

main

# test: r,r,r,r
