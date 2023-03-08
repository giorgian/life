# frozen_string_literal: true

require_relative "life/version"

# Simple Conway's Game of Life implementation
module Life
  autoload :Generation, "life/generation"
  autoload :Importer, "life/importer"
  autoload :Presenter, "life/presenter"

  class Error < StandardError; end
end
