class Score

  def score_line(line)
    sum = 0
    tally = line.compact.tally
    sum += 10 if tally.values.any? { 2 }
    sum
  end
end
