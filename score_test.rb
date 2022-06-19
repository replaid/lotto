# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'score'
require_relative 'board'

class ScoreTest < Minitest::Test
  def setup
    @score = Score.new
  end

  def test_can_score_all_singles
    [
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, 1],
      [nil, nil, nil, 1, 2],
      [nil, nil, 3, 1, 2],
      [nil, 4, 3, 1, 2],
      [12, 4, 3, 2, 1]
    ].each do |line|
      assert_equal(0, @score.score_line(line))
    end
  end

  def test_can_score_one_pair
    [
      [nil, nil, nil, 1, 1],
      [nil, nil, 2, 1, 1],
      [nil, 3, 2, 1, 1],
      [4, 3, 2, 1, 1]
    ].each do |line|
      assert_equal(10, @score.score_line(line))
    end
  end

  def test_can_score_two_pairs
    [
      [nil, 2, 2, 1, 1],
      [3, 2, 2, 1, 1]
    ].each do |line|
      assert_equal(20, @score.score_line(line))
    end
  end

  def test_can_score_triplet
    [
      [nil, nil, 1, 1, 1],
      [nil, 2, 1, 1, 1],
      [3, 2, 1, 1, 1]
    ].each do |line|
      assert_equal(30, @score.score_line(line))
    end
  end

  def test_can_score_quartet
    [
      [nil, 1, 1, 1, 1],
      [2, 1, 1, 1, 1]
    ].each do |line|
      assert_equal(50, @score.score_line(line))
    end
  end

  def test_can_score_full_house
    assert_equal(40, @score.score_line([1, 1, 1, 2, 2]))
  end

  def test_can_score_sequence
    assert_equal(25, @score.score_line([1, 2, 3, 4, 5]))
    assert_equal(0, @score.score_line([1, 2, 3, 4, 12]))
  end

  def test_can_return_total_score
    board = Board.new
    columns = [
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [6, 7, 8, 9, 10]
    ]
    columns.each_with_index do |column, x|
      column.each_with_index do |value, y|
        board[x, y] = value
      end
    end
    assert_equal(375, @score.score_total(board))
  end

  def test_can_return_total_score_for_empty_board
    board = Board.new
    assert_equal(0, @score.score_total(board))
  end
end
