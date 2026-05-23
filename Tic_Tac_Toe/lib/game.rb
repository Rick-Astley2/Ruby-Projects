# frozen_string_literal: true

require_relative 'board'
require_relative 'human_player'
require_relative 'conditions'

# Initializes and starts the tic_tac_toe game
class Game
  attr_accessor :board, :player1, :player2, :conditions

  def initialize
    self.board = Board.new
    self.player1 = HumanPlayer.new('Player 1', 'X')
    self.player2 = HumanPlayer.new('Player 2', 'O')
    self.conditions = Conditions.new(board)
  end

  def valid_move?(x, y, player_turn)
    return false if x.nil?

    if board.grid[x][y] == '_'
      board.grid[x][y] = player_turn.character
    else
      puts "#{player_turn.player} you can't place it there."
      return false
    end
    true
  end

  def start
    player_turn = player1
    loop do
      board.display
      x, y = player_turn.make_move

      next unless valid_move?(x, y, player_turn)

      if conditions.win?(player_turn)
        puts "#{player_turn.player} has won congrats!"
        board.display
        break
      elsif conditions.tie?
        puts 'You tied!'
      end
      player_turn = player_turn == player1 ? player2 : player1
    end
  end
end
