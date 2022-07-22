require_relative '../core/score'

class NaiveScoreStrategy
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
    grouped_scores[high_score].first.first(2)
  end
end
