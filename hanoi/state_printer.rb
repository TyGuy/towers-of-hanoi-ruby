module Hanoi
  class StatePrinter
    def self.print_state(board_state_array)
      new(board_state_array).print_state
    end

    def initialize(board_state_array)
      @board_state_array = board_state_array
    end

    def print_state
      base = print_board_base

      # this is not an off-by-one error, it's intentional
      # because we want one top row with just pegs
      rows = (0..(max_ring_size)).map do |row_num|
        print_row(row_num)
      end.reverse

      [*rows, base].join("\n")
    end

    private

    attr_reader :board_state_array

    def max_ring_size
      @max_ring_size ||= board_state_array.flatten.compact.size
    end

    def max_visual_ring_size
      @max_visual_ring_size ||= visual_ring_size(max_ring_size)
    end

    def board_width
      @board_width ||= max_visual_ring_size * 3 + 4
    end

    def visual_ring_size(ring_size)
      2 * ring_size + 1
    end

    def print_row(row_num)
      row = ''

      rings_for_row = board_state_array.map { |peg_array| peg_array[row_num] }

      # build 3 sections
      first_peg_offset = 0.5 * max_visual_ring_size
      if (ring_1_size = rings_for_row[0])
        # a little weird but this works because the size is the (visual size - 1) / 2
        ring_start = first_peg_offset - ring_1_size
        row += ' ' * ring_start + 'x' * visual_ring_size(ring_1_size)
      else
        row += ' ' * first_peg_offset + '|'
      end

      second_peg_offset = max_visual_ring_size + 1 - (ring_1_size || 0)
      if (ring_2_size = rings_for_row[1])
        ring_start = second_peg_offset - ring_2_size
        row += ' ' * ring_start + 'x' * visual_ring_size(ring_2_size)
      else
        row += ' ' * second_peg_offset + '|'
      end

      third_peg_offset = max_visual_ring_size + 1 - (ring_2_size || 0)
      if (ring_3_size = rings_for_row[2])
        ring_start = third_peg_offset - ring_3_size
        row += ' ' * ring_start + 'x' * visual_ring_size(ring_3_size)
      else
        row += ' ' * third_peg_offset + '|'
      end

      row
    end

    def print_board_base
      [
        '-' * board_width,
        ('|' + 'x' * (board_width - 2) + '|'),
        '-' * board_width,
      ].join("\n")
    end
  end
end
