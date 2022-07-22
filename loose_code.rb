require_relative 'strategy/naive_score_strategy'
require_relative 'core/board'

def make_draws
  (1..12).map do |i| [i]*4 end.flatten.shuffle.first(25)
end

def run_array(array)
  @strategy = NaiveScoreStrategy.new
  played_arr = []
  result_board = array.inject(Board.new) do |board, e|
    played_arr << e
    coordinates = @strategy.place(board.dup.freeze, e)
    board[coordinates.first, coordinates.last] = e
#    p played_arr
#    p board
#    p @score.score_total(board)
    board
  end
  result_board
end

score = Score.new
resut_bords = (1..1000).map do drawz = make_draws; bord = run_array(drawz); skor = score.score_total(bord); [drawz,bord,skor]  end

pp resut_bords

skorz = resut_bords.map(&:last)
p skorz
p skorz.inject(0.0, &:+) / skorz.size





#interesting_drawz = [12, 8, 1, 12, 12, 1, 8, 9, 3, 5, 1, 4, 6, 6, 11, 10, 5, 11, 10, 7, 3, 3, 12, 7, 10]
#@score = Score.new
#interesting_drawz = make_draws
#run_array(interesting_drawz)

