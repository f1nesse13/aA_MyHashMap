class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |ele, i|
      sum += ((sum << 8) + ele.to_s.ord + (sum >> 4))
    end
    return sum
  end 
end

class String
  def hash
    self.each_char.inject(0) do |sum, ele|
      ((sum << 8) + ele.ord + (sum >> 4))
    end
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.keys.sort
    arr.hash
  end
end
