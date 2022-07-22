# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'naive_score_strategy'
require_relative '../core/board'

class NaiveScoreStrategyTest < Minitest::Test
  def run_array(array)
    @strategy = NaiveScoreStrategy.new
    result_board = array.inject(Board.new) do |board, e|
      coordinates = @strategy.place(board.dup.freeze, e)
      board[coordinates.first, coordinates.last] = e
      board
    end
    result_board
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
      run_array([1]).rows
    )
  end

  def test_two_spins_of_same
    assert_equal(
      [
        [1, 1, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
      ],
      run_array([1, 1]).rows
    )
  end

  def test_two_spins_of_different
    assert_equal(
      [
        [1, nil, nil, nil, nil],
        [nil, 12, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
      ],
      run_array([1, 12]).rows
    )
  end

  def test_six_spins_pair_detection
    assert_equal(
      [
        [1, 1, 1, 1, nil],
        [nil, nil, nil, nil, 2],
        [nil, nil, nil, nil, 2],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
      ],
      run_array([1, 1, 1, 1, 2, 2]).rows
    )
  end
end
