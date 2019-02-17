class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    else
      raise 'Out of bounds'
    end
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num.is_a?(Integer) &&
    num.between?(0, @store.length)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    mod_ind = num % @store.length
    @store[mod_ind] << num
  end

  def remove(num)
    mod_ind = num % @store.length
    @store[mod_ind].delete(num) if self.include?(num)
  end

  def include?(num)
    mod_ind = num % @store.length
    @store[mod_ind].include?(num)
  end

  private

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self[num].include?(num)
      self[num] << num
      @count += 1
    end
    if @count == num_buckets
      @count -= @store.length / 2
      resize!
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket = num % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times do |n|
      @store << Array.new
    end
    re_insert!
  end

  def re_insert!
    @store.each do |arr|
      arr.each do |ele|
        insert(ele)
      end
    end
  end
end
