module Hanoi
  class Ring
    # could add validations for integer size 1 through 8
    attr_reader :size

    def initialize(size)
      @size = size
    end

    def to_s
      "ring_#{size}"
    end
  end
end
