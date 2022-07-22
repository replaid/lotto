# frozen_string_literal: true

# 5x5 grid.
class Board
  def initialize
    @columns = Array.new(5) { |_index| [nil, nil, nil, nil, nil] }
  end

  def dup
    result = self.class.new
    each_space do |x,y|
      result[x,y] = self[x,y]
    end
    result
  end

  def []=(x, y, value)
    raise "already have a value at #{[x, y]}" if self[x, y]
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

  def columns
    @columns.dup
  end

  def rows
    (0..4).map { |i| row(i) }
  end

  def all_lines
    @columns + rows
  end

  def each_space
    (0..4).each do |y|
      (0..4).each do |x|
        yield x, y
      end
    end
  end

  def all_empty_spaces
    empty_spaces = []
    each_space do |x, y|
      empty_spaces << [x,y] unless self[x,y]
    end
    empty_spaces
  end

  def loneliness(x, y)
    column(x).count(nil) + row(y).count(nil)
  end

  PIPE = '|'
  ROW_DECORATOR = '+--+--+--+--+--+'
  def inspect
    [
      ROW_DECORATOR,
      rows.map do |row|
        [
          PIPE,
          row.map do |value|
            if value
              sprintf('%2d', value)
            else
              '  '
            end
          end.join(PIPE),
          PIPE
        ].join
      end.join("\n#{ROW_DECORATOR}\n"),
      ROW_DECORATOR,
      ''
    ].join("\n")
  end
end
