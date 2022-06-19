# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'dumb_strategy'

class DumbStrategyTest < Minitest::Test
  def run_array(array)
    @strategy = DumbStrategy.new
    result_board = array.inject(Board.new) do |board, e|
      coordinates = @strategy.place(board.dup.freeze, e)
      board[coordinates.first, coordinates.last] = e
      board
    end
    result_board.columns
  end

  def test_one_spin
    assert_equal(
      [
        [1, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
      ],
      run_array([1])
    )
  end

  def test_three_spins
    assert_equal(
      [
        [1, 2, 3, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
      ],
      run_array([1,2,3])
    )
  end
end
