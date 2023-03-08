# frozen_string_literal: true

module Life
  # Represents a single generation
  class Generation
    NEIGHBOURS = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]].freeze

    attr_reader :number, :width, :height, :grid

    def initialize(number, width, height, grid)
      @number = number
      @width = width
      @height = height
      @grid = grid
    end

    def next_step
      next_grid = []
      height.times do |y|
        row = []
        width.times { |x| row << next_value(x, y) }
        next_grid << row
      end

      Generation.new(number + 1, width, height, next_grid)
    end

    private

    def next_value(column, row)
      old_value = grid[row][column]
      neighs = neighbours(column, row)
      old_value ? neighs.between?(2, 3) : neighs == 3
    end

    def neighbours(column, row)
      result = 0
      NEIGHBOURS.each do |x, y|
        next unless (column + x).between?(0, width - 1) && (row + y).between?(0, height - 1)

        result += 1 if grid[row + y][column + x]
      end

      result
    end
  end
end
