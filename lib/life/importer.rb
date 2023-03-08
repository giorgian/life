# frozen_string_literal: true

module Life
  # Imports a Generation from a string representation
  class Importer
    NUM_REGEXP = /^Generation (?<generation>\d+):$/.freeze
    DIMS_REGEXP = /^(?<rows>\d+) (?<cols>\d+)$/.freeze
    GRID_REGEXP = /^[.*]+$/.freeze

    def import(file_content)
      num_line, dims_line, *grid_lines = file_content.lines.map(&:strip)
      raise Life::Error unless num_line && dims_line && grid_lines

      number = extract_number(num_line)
      width, height = extract_dimensions(dims_line)
      grid = extract_grid(width, height, grid_lines)

      Generation.new(number, width, height, grid)
    end

    private

    def extract_number(num_line)
      match = NUM_REGEXP.match(num_line)
      raise Life::Error unless match

      match[:generation].to_i
    end

    def extract_dimensions(dims_line)
      match = DIMS_REGEXP.match(dims_line)
      raise Life::Error unless match

      height = match[:rows].to_i
      raise Life::Error if height < 1

      width = match[:cols].to_i
      raise Life::Error if width < 1

      [width, height]
    end

    def extract_grid(width, height, grid_lines)
      raise Life::Error unless valid_grid?(width, height, grid_lines)

      grid_lines.map { |line| line.chars.map { |cell| cell == "*" } }
    end

    def valid_grid?(width, height, grid_lines)
      grid_lines.size == height &&
        grid_lines.all? { |row| row.size == width } &&
        grid_lines.all? { |row| GRID_REGEXP =~ row }
    end
  end
end
