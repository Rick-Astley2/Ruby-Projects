# frozen_string_literal: true

require_relative 'lib/game'

def main
  puts 'Instructions: Place your tile like 0,0 only going up to 2 with 0,0 being top left.'
  new_game = Game.new
  new_game.start
end

main
