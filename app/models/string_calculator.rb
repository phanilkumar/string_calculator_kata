class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?
    
    numbers_array = parse_numbers(numbers)
    validate_no_negatives(numbers_array)
    filtered_numbers = filter_large_numbers(numbers_array)
    filtered_numbers.sum
  end

  private

  def parse_numbers(numbers)
    if numbers.start_with?('//')
      delimiter, numbers_part = numbers.split("\n", 2)
      custom_delimiter = delimiter[2..-1]  # Remove '//' prefix
      numbers_part.split(custom_delimiter).map(&:to_i)
    else
      numbers.split(/[,\n]/).map(&:to_i)
    end
  end

  def validate_no_negatives(numbers_array)
    negative_numbers = numbers_array.select { |n| n < 0 }
    if negative_numbers.any?
      raise ArgumentError, "negative numbers not allowed #{negative_numbers.join(',')}"
    end
  end

  def filter_large_numbers(numbers_array)
    numbers_array.select { |n| n <= 1000 }
  end
end
