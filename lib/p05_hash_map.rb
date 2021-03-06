require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if @count == num_buckets
      resize!
    end
    if self.include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if self.include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |linked_ls|
      linked_ls.each do |node|
        yield node.key, node.val
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_list = @store.dup
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0
    old_list.each do |link_ls|
      link_ls.each do |node|
        set(node.key, node.val)
      end
    end 
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    bucket_num = key.hash % num_buckets
    @store[bucket_num]
  end
end
