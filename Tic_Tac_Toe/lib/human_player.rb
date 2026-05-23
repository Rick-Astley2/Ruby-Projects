# frozen_string_literal: true

# Initializes player and gets there move
class HumanPlayer
  attr_accessor :player, :character

  def initialize(player, character)
    self.player = player
    self.character = character
  end

  def make_move
    loop do
      print "#{player} place your tile. "
      move = gets.chomp.strip

      parts = move.split(',', 2)
      return parts.map(&:to_i) if parts.size == 2 && parts.all? { |part| part =~ /\A[0-2]\z/ }

      puts 'Invalid input'
    end
  end
end
