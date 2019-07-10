module CharToNum
  ROMAN_NUMERALS = {
    i: 1,
    v: 5,
    x: 10
  }

  #takes double letter and roman numeral numbering systems
  #into account as normal alphabetical sort fails for this case
  def treat_char_as_num?(num)
    return num.to_i if num.match?(/(?=.*?[a-zA-Z])(?=.*?[0-9])/)
    num.scan(')').empty? ? num.strip : char_to_num(num)
  end
  
  def detect_roman_numerals(num)
    num.match?(/(?=.*?[ivx])/)
  end

  def convert_roman_to_arabic(num)
    num = handle_exception(num)

    sum = 0
    num.split('').each do |n|
      sum += ROMAN_NUMERALS[n.to_sym]
    end
    
    sum
  end

  def char_to_num(num)
    num = num.gsub(')','')
    return convert_roman_to_arabic(num) if detect_roman_numerals(num)
    num.chars.map(&:ord).sum
  end

  def handle_exception(num)
    return num if num.scan('iv').empty? && num.scan('ix').empty?
    num.gsub('iv', 'iiii').gsub('ix', 'viiii')
  end
end