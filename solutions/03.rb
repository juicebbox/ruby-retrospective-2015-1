class Sequence
  include Enumerable
  def initialize(length)
    @length = length
    @sequence = Array.new(length)
  end

  def each
    0.upto(@sequence.length - 1) do |x|
      yield @sequence[x]
    end
  end

  def rationalize (length)
    (1..(length - 1)).each do |i|
      (1..(length - 1)).each do |j|
        @array[i-1][j-1] = Rational(i,j)
      end
    end
  end
  def add_prime
    i=1
    prime = 3
    until i > @length - 1 do
      if prime?(prime) then
        @sequence[i] = prime
        prime += 1
        i += 1
      else prime += 1
      end
    end
  end
end

class RationalSequence < Sequence
  def initialize(length)
    super(length)
    if length == 0 then @sequence = nil
    else
      @sequence[0] = Rational(1,1)
    end
    @array = Array.new(length-1){Array.new(length-1)}
    last = @sequence[0]
    if length > 1 then rationalize (length) end
    i=1
    @array.each do |x,y|
      # Take only the needed number from @array into @Sequence
    end
  end

end

class PrimeSequence < Sequence
  def initialize(length)
    super(length)
    @sequence[0] = 2
    if length > 1
      add_prime
    end
  end
end

class FibonacciSequence < Sequence
  def initialize(length, initial = {first: 1, second: 1})
    super(length)
    if @length == 1
      @sequence[0] = initial[:first]
    elsif @length >= 2
      @sequence= [initial[:first], initial[:second]]
      i = 2
      until i > @length - 1 do
        @sequence[i] = @sequence[i-1] + @sequence[i-2]
        i += 1
      end
    end
  end
end

module DrunkenMathematician
  module_function
  def meaningless (n)
    if n == 1 then
      '1/1'.to_r
    else
      rational_sequence = RationalSequence.new(n)
      array = rational_sequence.to_a
      get_product(n,array)
      '#{product_one.to_r}/#{product_two.to_r}'.to_r
    end
  end

  def aimless (n)
    sequence = PrimeSequence.new(n).to_a
    if n % 2 == 1 then sequence << 1 end
    sum = 0
    for i in 0..((n-1)/2)
      sum += Rational(sequence[i*2], sequence[i*2+1])
    end
    sum.to_r
  end
  def get_product(n,array)
    product_one=1.to_r
    product_two=1.to_r
    for x in 0..(n-1)
      if prime? array[x].to_r.denominator or prime? array[x].to_r.nomerator
        product_one *= array[x].to_r
        print product_one
      else
        product_two *= array[x].to_r
      end
    end
  end
  def worthless (n)
  end
end

def prime?(number)
  if number == 2 then true end
  for n in 2..(number - 1)
    if number % n == 0
      return false
    end
  end
  true
end
