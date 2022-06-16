# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'score'

class ScoreTest < Minitest::Test
  def test_can_score_line_of_nils
    score = Score.new
    assert_equal(0, score.score_line([nil, nil, nil, nil, nil]))
  end

  def test_can_score_line_with_nils_and_one_pair
    score = Score.new
    assert_equal(10, score.score_line([nil, nil, nil, 1, 1]))
  end
end
