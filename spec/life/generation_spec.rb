# frozen_string_literal: true

require "spec_helper"

RSpec.describe Life::Generation do
  it "can be instantiated" do
    result = described_class.new(1, 2, 3, [[false, true, false], [true, false, true]])
    expect(result.number).to eq 1
  end

  describe "#next_step" do
    subject(:next_step) { initial_step.next_step }

    let(:initial_step) { described_class.new(1, 4, 4, grid) }

    let(:grid) do
      [
        [false, true, false, true],
        [true, true, true, false],
        [true, true, true, false],
        [true, true, true, false]
      ]
    end

    let(:next_grid) do
      [
        [true, true, false, false],
        [false, false, false, true],
        [false, false, false, true],
        [true, false, true, false]
      ]
    end

    it "returns the next step" do
      expect(next_step.number).to eq 2
      expect(next_step.width).to eq initial_step.width
      expect(next_step.height).to eq initial_step.height
      expect(next_step.grid).to eq next_grid
    end
  end
end
