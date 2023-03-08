# frozen_string_literal: true

require "spec_helper"

RSpec.describe Life::Importer do
  describe "#import" do
    context "with invalid file contents" do
      let(:bad_file_contents) do
        [
          # Empty file
          "",
          # Missing header
          "4 8\n........\n....*...\n...**...\n........\n",
          # Missing dimensions
          "Generation 3:\n........\n....*...\n...**...\n........\n",
          # Not enough rows
          "Generation 3:\n4 8\n........\n...**...\n........\n",
          # Too many rows
          "Generation 3:\n4 8\n........\n........\n....*...\n...**...\n........\n",
          # Bad char in grid
          "Generation 3:\n4 8\n........\n....*...\n...**...\n....!...\n",
          # Not enough columns
          "Generation 3:\n4 8\n........\n....*...\n...**...\n.......\n",
          # Too many columns
          "Generation 3:\n4 8\n........\n....*...\n...**...\n.........\n",
          # Zero rows
          "Generation 3:\n0 1\n\n"
        ]
      end

      it "gives an error" do
        bad_file_contents.each do |file_content|
          expect { described_class.new.import(file_content) }.to raise_error Life::Error
        end
      end
    end

    context "with valid file contents" do
      subject(:generation) { described_class.new.import(valid_file_content) }

      let(:valid_file_content) do
        <<~FILE
          Generation 3:
          4 8
          ........
          ....*...
          ...**...
          ........
        FILE
      end

      it "returns a valid Generation" do
        expect(generation).to be_a Life::Generation
        expect(generation.height).to eq 4
        expect(generation.width).to eq 8
        expect(generation.grid[0][5]).to be_falsey
        expect(generation.grid[1][4]).to be_truthy
      end
    end
  end
end
