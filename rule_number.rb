require 'pry'

class RuleNumber
  def initialize(number)
  	@num = number
  end

	# -1 means self < other
	# 1 means self > other
	# 0 means identical
  def <=>(other)
  	if only_integers
  		@num <=> other
  	else
  		numbers1, numbers2 = parse_number_systems(@num.to_s, other.to_s)
  		@equivalent = true
  		while @equivalent
  			numbers1.each_with_index { |number, i|
  				@result = 1 if number.to_i > numbers2[i].to_i
  				@result =  -1 if number.to_i  < numbers2[i].to_i
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

  def parse_number_systems(n, other)
  	if n.rindex(' ')

  	else
  		binding.pry
  		return n.split('.'), other.split('.')
  	end
  end
end
