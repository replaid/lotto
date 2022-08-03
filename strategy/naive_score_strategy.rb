require_relative '../core/score'

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
    score = Score.new
    scored_things = board.all_empty_spaces.map do |x, y|
      new_board = board.dup
      new_board[x,y] = new_number
      new_score = score.score_total(new_board)
      [x, y, new_score]
    end
    grouped_scores = scored_things.group_by {|x,y,new_score| new_score}
    high_score = grouped_scores.keys.sort.last
    high_scoring_spaces = grouped_scores[high_score].map {|x,y,_score| [x,y] }
    lonelinesses = high_scoring_spaces.map { |x,y| [x,y,board.loneliness(x,y)]}
    max_loneliness = lonelinesses.map(&:last).max
    lonelinesses.detect {|x,y,loneliness| loneliness == max_loneliness}.first(2)
  end
end
