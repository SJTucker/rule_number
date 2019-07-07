require 'pry'

class RuleNumber
	attr :parsed_number

  def initialize(number)
  	@num = number
  	@parsed_number = parsed_number_system unless only_integers
  end

	# -1 means self < other
	# 1 means self > other
	# 0 means identical
  def <=>(other)
  	if only_integers
  		@num <=> other
  	else
  		@equivalent = true
  		while @equivalent
  			parsed_number.each_with_index { |number, i|
  				@result = 1 if number > other.parsed_number[i]
  				@result =  -1 if number  < other.parsed_number[i]
  				@equivalent = false if @result
  			}
  		end
  		@result
  	end
  end

  def to_s
  	@num
  end

  def only_integers
  	@num.scan(/a-zA-z/).empty? && @num.scan(/\D/).empty?
  end

  def parsed_number_system
  	if @num.rindex(' ')

  	else
  		return @num.gsub(')','').split(/[\.,\(,\-]/).reject(&:empty?).map(&:to_i)
  	end
  end
end
