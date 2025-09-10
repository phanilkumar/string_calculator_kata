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
      custom_delimiter = extract_delimiter(delimiter)
      numbers_part.split(custom_delimiter).map(&:to_i)
    else
      numbers.split(/[,\n]/).map(&:to_i)
    end
  end

  def extract_delimiter(delimiter_string)
    # Remove '//' prefix
    delimiter_content = delimiter_string[2..-1]
    
    # Check if it's multi-character delimiter format [delimiter]
    if delimiter_content.start_with?('[') && delimiter_content.end_with?(']')
      delimiter_content[1..-2]  # Remove [ and ]
    else
      delimiter_content  # Single character delimiter
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
