module Hanoi
  class Peg
    attr_reader :rings

    def initialize(rings = [])
      @rings = rings
    end

    def remove_ring
      @rings.pop
    end

    def add_ring(ring)
      @rings.push(ring)
    end

    # These should all be delegators
    def empty?
      rings.empty?
    end

    def last
      rings.last
    end
  end
end
