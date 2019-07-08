require_relative 'char_to_num'

class RuleNumber
	include ::CharToNum
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
			other_number = other.parsed_number[i]

			return 1 if other_number.nil?
			return -1 if numbers_equivalent_but_other_has_more_parts?(number, other_number, i)

			result = number <=> other_number

			return result if result != 0
		}
  end

  def numbers_equivalent_but_other_has_more_parts?(number, other_number, index)
  	number == other_number && index == parsed_number.length - 1 && !other_number.nil?
  end
end
