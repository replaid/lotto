# frozen_string_literal: true

class Tools
  def initialize(board)
    @board = board
  end

  def high_scoring_spaces(new_number)
    score = Score.new
    scored_things = @board.all_empty_spaces.map do |x, y|
      new_board = @board.dup
      new_board[x,y] = new_number
      new_score = score.score_total(new_board)
      [x, y, new_score]
    end
    grouped_scores = scored_things.group_by {|x,y,new_score| new_score}
    high_score = grouped_scores.keys.sort.last
    grouped_scores[high_score].map {|x,y,_score| [x,y] }
  end

  def loneliest(spaces)
    lonelinesses = spaces.map do |x,y|
      [x,y,@board.loneliness(x,y)]
    end
    max_loneliness = lonelinesses.map(&:last).max
    all_with_max_loneliness = lonelinesses.find_all {|x,y,loneliness| loneliness == max_loneliness}
    all_with_max_loneliness.map {|x,y,_loneliness| [x,y]}
  end
end
