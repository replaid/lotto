# frozen_string_literal: true

# 5x5 grid.
class Board
  def initialize
    @columns = Array.new(5) { |_index| [nil, nil, nil, nil, nil] }
  end

  def []=(x, y, value)
    @columns[x][y] = value
  end

  def [](x, y)
    @columns[x][y]
  end

  def row(y)
    @columns.map { |column| column[y] }
  end

  def column(x)
    @columns[x]
  end

  def rows
    (0..4).map { |i| row(i) }
  end

  def all_lines
    @columns + rows
  end
end
