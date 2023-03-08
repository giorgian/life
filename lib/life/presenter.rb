# frozen_string_literal: true

module Life
  # Creates an ASCII representation of a generation
  class Presenter
    def represent(generation)
      grid = generation.grid.map { |row| row.map { |cell| cell ? "*" : "." }.join }.join("\n")
      "Generation: #{generation.number}\n#{grid}\n"
    end
  end
end
