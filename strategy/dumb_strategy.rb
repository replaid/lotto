require_relative '../core/board'

class DumbStrategy
  # Given a board and a newly spun number, return the x, y coordinates where we
  # want it to be placed.
  def place(board, new_number)
    x = board.columns.find_index do |column|
      column.any? { |item| item.nil? }
    end
    y = board.column(x).find_index do |item|
      item.nil?
    end
    [x, y]
  end
end
