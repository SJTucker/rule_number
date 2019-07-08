require 'pry'

class RuleNumber
	attr :parsed_number
	attr :num

	ROMAN_NUMERALS = {
		i: 1,
		v: 5,
		x: 10
	}

  def initialize(number)
  	@num = number
  	@parsed_number = parsed_number_system
  	#binding.pry
  end

	# -1 means self < other
	# 1 means self > other
	# 0 means identical
  def <=>(other)
  	sort_numbers(other)
  end

  def to_s
  	@num
  end

  def numeric?(num)
    Float(num) != nil rescue false
  end

  #splits original number into components for comparison
  #splits on ., (, -, and ' '
  def parsed_number_system
		nums = @num.split(/[\.,\(,\-, ]/).reject(&:empty?)
		nums.map!{ |num| numeric?(num) ? num.gsub('#','').to_i : treat_char_as_num?(num) }
		nums
  end

  def sort_numbers(other)
		parsed_number.each_with_index { |number, i|
			other_number = other.parsed_number[i]
			return 1 if other_number.nil?
			return -1 if numbers_equivalent_but_other_has_more_parts?(number, other_number, i)

			result = 1 if number > other_number
			result =  -1 if number  < other_number
			result = number <=> other_number unless number.is_a?(Integer)

			return result if result && result != 0
		}
  end

  def numbers_equivalent_but_other_has_more_parts?(number, other_number, index)
  	number == other_number && index == parsed_number.length - 1 && !other_number.nil?
  end

  #takes double letter numbering system into account as normal alphabetical sort fails for this case
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
