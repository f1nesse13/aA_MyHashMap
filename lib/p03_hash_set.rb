class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == @store.length
      resize!
    end
    if !self[key].include?(key)
      self[key].push(key)
      @count += 1
    end
  end

  def re_insert(key)
    self[key].push(key)
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    hashed_key = num.hash
    bucket = hashed_key % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

  def resize!
    values = @store.map do |arr|
      arr.each do |val|
        val
      end
    end
    num_buckets.times do |n|
      @store << Array.new
    end
    values.each do |val|
      self.re_insert(val)
    end
  end

end
