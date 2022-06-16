# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'board'

class BoardTest < Minitest::Test
  def test_can_add_a_value
    board = Board.new
    board[1, 2] = 6
    assert_equal(6, board[1, 2])
  end

  def test_can_report_a_column
    board = Board.new
    board[0, 0] = 1
    board[0, 1] = 2
    board[0, 2] = 3
    board[0, 3] = 4
    board[0, 4] = 5
    assert_equal([1, 2, 3, 4, 5], board.column(0))
  end

  def test_can_report_a_row
    board = Board.new
    board[0, 0] = 1
    board[1, 0] = 2
    board[2, 0] = 3
    board[3, 0] = 4
    board[4, 0] = 5
    assert_equal([1, 2, 3, 4, 5], board.row(0))
  end
end
