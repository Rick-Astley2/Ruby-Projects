# frozen_string_literal: true

require_relative 'lib/game'

def main
  puts 'Input 1 letter in your guess or type save, to save your game.'
  game = Game.new
  game.start
end

main
