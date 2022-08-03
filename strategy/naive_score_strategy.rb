require_relative '../core/score'
require_relative '../strategy/tools'

class NaiveScoreStrategy
  # * Get empty spaces.
  #
  # * Score every empty space.
  #
  # * Narrow down to the empty spaces that share the highest score on this
  #   move.
  #
  # * Find loneliest spaces (fewest numbers placed in the same column or row)
  #   so we can maximize distribution, and grab one of the spaces that shares
  #   the highest loneliness score.
  def place(board, new_number)
    tools = Tools.new(board)
    candidates = tools.high_scoring_spaces(new_number)
    all_loneliest_spaces = tools.loneliest(candidates)
    all_loneliest_spaces.first
  end
end
