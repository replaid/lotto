class Score

  EMPTY = {}

  ONE_PAIR = {2=>1}

  TWO_PAIRS = {2=>2}

  MAYBE_SEQUENCE = {1=>5}

  FULL_HOUSE = {3=>1, 2=>1}

  TRIPLET = {3=>1}

  QUARTET = {4=>1}

  def score_line(line)
    # Eliminate nils, then count occurrences of each value.
    tally = line.compact.tally

    # Now count occurrences of singles, doubles, triplets, and quartets.
    tally_tally = tally.values.tally

    # Remove singles counts to decomplicate our logic, since we only look at
    # them in one case.
    group_tally = tally_tally.dup.delete_if { |group_size, _occurrences| group_size == 1 }

    # Now return a score based mostly on which pattern the group tally matches.
    case group_tally
    when EMPTY
      # This is the only wrinkle left: we have to recognize sequences, which
      # look like 5 singles in the tally and were removed in the
      # simplification, so look "empty" to the group tally.
      #
      # Then once we know we have 5 singles, we can just check that they span 5
      # consecutive integers to see if we have a sequence or not.
      if (tally_tally == MAYBE_SEQUENCE) && is_sequence?(line)
        25
      else
        0
      end
    when ONE_PAIR
      10
    when TWO_PAIRS
      20
    when TRIPLET
      30
    when QUARTET
      50
    when FULL_HOUSE
      40
    else
      raise 'unrecognized case: ' + tally_tally.inspect
    end
  end

  def is_sequence?(line)
    sorted = line.compact.sort
    (sorted.first.to_i + 4) == sorted.last
  end

  def score_total(board)
    scores = board.all_lines.map do |line| score_line(line) end
    scores.sum

  end

end


