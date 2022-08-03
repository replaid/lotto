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

  def test_can_report_all_lines
    input_columns = [
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [6, 7, 8, 9, 10]
    ]
    board = Board.new
    input_columns.each_with_index do |column, x|
      column.each_with_index do |value, y|
        board[x, y] = value
      end
    end
    columns_then_rows = [
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [6, 7, 8, 9, 10],
      [ 1, 1, 1, 1, 6 ],
      [ 2, 2, 2, 2, 7 ],
      [ 3, 3, 3, 3, 8 ],
      [ 4, 4, 4, 4, 9 ],
      [ 5, 5, 5, 5, 10 ]
    ]
    assert_equal(columns_then_rows, board.all_lines)
  end

  def test_all_empty_spaces
    board = Board.new
    board[0, 0] = 1
    board[1, 1] = 1
    all_empties = board.all_empty_spaces
    assert_equal(23, all_empties.size)
    assert_equal([1, 0], all_empties.first)
    assert_equal([2, 0], all_empties[1])
    assert_equal([4, 4], all_empties.last)
  end

  def test_loneliness
    board = Board.new
    board[0, 0] = 1
    board[1, 1] = 1
    board[2, 1] = 1
    assert_equal(8, board.loneliness(3, 1))
    assert_equal(8, board.loneliness(1, 0))
    assert_equal(10, board.loneliness(3, 3))
  end

  def test_dup_dupes_columns_too
    board = Board.new
    duplicated_board = board.dup
    assert_nil(board[4,4])
    duplicated_board[4,4] = 1
    assert_nil(board[4,4])
  end

  def test_inspect
    expected = <<~EOS
      +--+--+--+--+--+
      |  | 1|12|  |  |
      +--+--+--+--+--+
      |  |  |  |  |  |
      +--+--+--+--+--+
      |  |  |  |  |  |
      +--+--+--+--+--+
      |  |  |  |  |  |
      +--+--+--+--+--+
      |  |  |  |  |  |
      +--+--+--+--+--+
    EOS
    board = Board.new
    board[1,0] = 1
    board[2,0] = 12
    assert_equal(expected, board.inspect)
  end
end
