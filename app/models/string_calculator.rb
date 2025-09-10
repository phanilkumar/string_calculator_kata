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
      delimiters = extract_delimiters(delimiter)
      split_by_delimiters(numbers_part, delimiters).map(&:to_i)
    else
      numbers.split(/[,\n]/).map(&:to_i)
    end
  end

  def extract_delimiters(delimiter_string)
    # Remove '//' prefix
    delimiter_content = delimiter_string[2..-1]
    
    # Check if it contains multiple delimiters [delim1][delim2]
    if delimiter_content.include?('][')
      # Multiple delimiters: extract each [delimiter] part
      delimiter_content.scan(/\[([^\]]+)\]/).flatten
    elsif delimiter_content.start_with?('[') && delimiter_content.end_with?(']')
      # Single multi-character delimiter
      [delimiter_content[1..-2]]
    else
      # Single character delimiter
      [delimiter_content]
    end
  end

  def split_by_delimiters(text, delimiters)
    # Start with the original text
    result = [text]
    
    # Split by each delimiter in sequence
    delimiters.each do |delimiter|
      result = result.flat_map { |part| part.split(delimiter) }
    end
    
    result
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
