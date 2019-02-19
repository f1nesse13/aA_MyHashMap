
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = self.prev
    @prev.next = self.next
    @key, @val = nil, nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    return false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = last
    new_node.next = @tail
    last.next = new_node
    @tail.prev = new_node
  end

  def update(key, val)
    if self.include?(key)
      each do |node|
        if node.key == key
          node.val = val
        end
      end
    end
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
      end
    end
  end

  def each
    current = first
    until current == @tail
      yield(current)
      current = current.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
