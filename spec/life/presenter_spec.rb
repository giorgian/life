# frozen_string_literal: true

require "spec_helper"

RSpec.describe Life::Presenter do
  describe "#represent" do
    subject(:presenter) { described_class.new }

    let(:generation) { Life::Generation.new(2, 3, 3, grid) }
    let(:grid) { [[false, true, false], [true, false, true], [false, true, false]] }

    it "returns an ASCII representation of a Generation" do
      expect(presenter.represent(generation)).to eq "Generation: 2\n.*.\n*.*\n.*.\n"
    end
  end
end
