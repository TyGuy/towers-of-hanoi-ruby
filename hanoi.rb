require_relative 'hanoi/board'
require_relative 'hanoi/peg'
require_relative 'hanoi/ring'
require_relative 'hanoi/state_printer'
require_relative 'hanoi/game'

Hanoi::Game.new.loop
