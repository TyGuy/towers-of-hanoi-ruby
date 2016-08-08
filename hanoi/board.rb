require_relative 'peg'
require_relative 'ring'

module Hanoi
  class Board
    InvalidMoveError = Class.new(StandardError)
    DEFAULT_SIZE = 8

    attr_reader :size, :pegs

    def initialize(size = DEFAULT_SIZE)
      @size = size

      rings = (1..@size).map { |i| Ring.new(i) }.reverse

      peg1 = Peg.new
      peg2 = Peg.new
      peg3 = Peg.new(rings)

      @pegs = [peg1, peg2, peg3]
    end

    def move_ring(from_idx, to_idx)
      from = @pegs[from_idx]
      to = @pegs[to_idx]

      raise InvalidMoveError, "Can't make that move: peg is empty" if from.empty?
      if !to.empty? && from.last.size > to.last.size
        raise InvalidMoveError, "Can't move larger ring on top of smaller"
      end

      ring = from.remove_ring
      to.add_ring(ring)
    end

    def state_array
      @pegs.map do |peg|
        peg.rings.map(&:size)
      end
    end
  end
end
