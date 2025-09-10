require 'rails_helper'

RSpec.describe StringCalculator do
  describe '#add' do
    it 'returns 0 for an empty string' do
      calculator = StringCalculator.new
      expect(calculator.add('')).to eq(0)
    end

    it 'returns the number itself for a single number' do
      calculator = StringCalculator.new
      expect(calculator.add('1')).to eq(1)
    end

    it 'returns the sum for two comma-separated numbers' do
      calculator = StringCalculator.new
      expect(calculator.add('1,5')).to eq(6)
    end

    it 'returns the sum for any amount of numbers' do
      calculator = StringCalculator.new
      expect(calculator.add('1,2,3,4,5')).to eq(15)
    end

    it 'returns the sum for numbers separated by newlines' do
      calculator = StringCalculator.new
      expect(calculator.add("1\n2,3")).to eq(6)
    end

    it 'returns the sum for numbers with custom delimiter' do
      calculator = StringCalculator.new
      expect(calculator.add("//;\n1;2")).to eq(3)
    end

    it 'throws an exception for negative numbers' do
      calculator = StringCalculator.new
      expect { calculator.add('1,-2,3') }.to raise_error(ArgumentError, 'negative numbers not allowed -2')
    end

    it 'throws an exception for multiple negative numbers' do
      calculator = StringCalculator.new
      expect { calculator.add('1,-2,-3,4') }.to raise_error(ArgumentError, 'negative numbers not allowed -2,-3')
    end
  end
end