# frozen_string_literal: true

# Player grabs inputs for there guess and for if they want to do there own code
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

      return choice if %w[yes no].include?(choice)

      puts 'Invalid input please type computer or me.'
    end
  end

  def player_code
    print 'Create a code: '
    prompt_player
  end
end
