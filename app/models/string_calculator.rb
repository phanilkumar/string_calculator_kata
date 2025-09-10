class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?
    
    if numbers.start_with?('//')
      delimiter, numbers_part = numbers.split("\n", 2)
      custom_delimiter = delimiter[2..-1]  # Remove '//' prefix
      numbers_part.split(custom_delimiter).map(&:to_i).sum
    else
      numbers.split(/[,\n]/).map(&:to_i).sum
    end
  end
end
