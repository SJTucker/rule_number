require 'pry'

class RuleNumber
	attr :parsed_number

  def initialize(number)
  	@num = number
  	@parsed_number = parsed_number_system
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
			#binding.pry
			other_number = other.parsed_number[i]
			return 1 if other_number.nil?
			return -1 if numbers_equivalent_but_other_has_more_parts?(number, other_number)
			#return 1 if number == parsed_number.last && !other_number[i+1].nil?

			result = 1 if number > other_number
			result =  -1 if number  < other_number
			result = number <=> other_number unless number.is_a?(Integer)

			return result if result && result != 0
			#binding.pry
		}
  end

  def numbers_equivalent_but_other_has_more_parts?(number, other_number)
  	number == other_number && number == parsed_number.last && !other_number.nil?
  end

  #takes double letter numbering system into account as normal alphabetical sort fails for this case
  def treat_char_as_num?(num)
  	return num.to_i if num.match?(/(?=.*?[a-zA-Z])(?=.*?[0-9])/)
  	num.scan(')').empty? ? num.strip : num.chars.map(&:ord).sum
  end

  def detect_roman_numerals

  end
end
