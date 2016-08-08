require_relative 'board'
require_relative 'state_printer'

module Hanoi
  class Game
    VALID_MOVE_KEYS = %w(j k l).freeze
    attr_reader :board, :start_peg

    def initialize
      @board = Board.new
      @start_peg = board.pegs.reject(&:empty?).first
    end

    def loop
      make_move until game_won?
      puts StatePrinter.print_state(board.state_array)
      puts '!!!!!!!!!!!!!!!'
      puts '!! CONGRATS !!!'
      puts '!!!!!!!!!!!!!!!'
      puts '!!! YOU WON !!!'
      puts '!!!!!!!!!!!!!!!'
    end

    private

    def make_move
      puts "\n\n"
      puts StatePrinter.print_state(board.state_array)
      puts 'Make a move: (use j, k, and l keys):'
      move_keys = gets.chomp.downcase

      keys_array = string_to_array(move_keys)
      unless keys_array.length == 2 && keys_array.all? { |k| VALID_MOVE_KEYS.include?(k) }
        print_error('Invalid move: invalid keys.')
        return
      end

      from_idx = VALID_MOVE_KEYS.index(keys_array.first)
      to_idx = VALID_MOVE_KEYS.index(keys_array.last)

      begin
        board.move_ring(from_idx, to_idx)
      rescue Hanoi::Board::InvalidMoveError => ex
        print_error("Invalid move: #{ex.message}")

      end
    end

    def print_error(error_msg)
      puts '!' * error_msg.length
      puts error_msg
      puts '!' * error_msg.length
      sleep 0.5
    end

    def string_to_array(string)
      string.each_char.map { |c| c }
    end

    def game_won?
      other_pegs = pegs.reject { |p| p == start_peg }

      # we only have to check size because we know all pegs
      # will be in correct size order at all times
      other_pegs.any? { |peg| peg.rings.size == board.size }
    end

    def pegs
      board.pegs
    end
  end
end
