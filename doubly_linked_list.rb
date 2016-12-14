class DoublyLinkedList
  attr_reader :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  # Use this nested class for storing the values of the DoublyLinkedList. Each
  # DoublyLinkedList::Node contains the value at its index, and a link to the
  # DoublyLinkedList::Node at the next index (called the "child" here), and at
  # the previous index (called "previous"). If the child is nil, that denotes
  # the last element of the DoublyLinkedList, while a nil previous denotes the
  # first.
  class Node
    attr_accessor :value, :previous, :child

    def initialize(value, previous = nil, child = nil)
      @value = value
      @previous = previous
      @child = child
    end
  end

  # Define a method ">>" which takes a single argument. This method should
  # prepend the argument to the beginning of this DoublyLinkedList and increase
  # the size by 1. The return value must be self.

  def >> (value)
    @head = Node.new(value, nil, @head)

    if @head.child
      @head.child.previous = @head
    else
      @tail = @head
    end

    @size += 1
    return self
  end

  # Define a method "<<" which takes a single argument. This method should
  # append the argument to the end of this DoublyLinkedList and increase the
  # size by 1. The return value must be self.

  def << (value)
    @tail = Node.new(value, @tail, nil)

    if @tail.previous
      @tail.previous.child = @tail
    else
      @head = @tail
    end

    @size += 1
    return self
  end

  # Define a "first" method which takes no arguments. This method should return
  # the value of that item. An IndexError should be raised if the list is empty.

  def first
    raise IndexError, "List is empty" if size == 0

    return @head.value
  end

  # Define a "last" method which takes no arguments. This method should return
  # the value of that item. An IndexError should be raised if the list is empty.

  def last
    raise IndexError, "List is empty" if size == 0

    return @tail.value
  end

  # Define a "delete_first" method which takes no arguments. This method should
  # delete the first item in the list and return the value of that item. The
  # size must be reduced by 1. An IndexError should be raised if the list is
  # empty.

  def delete_first
    raise IndexError, "List is empty" if size == 0

    deleted = @head.value

    @head = @head.child

    if @head
      @head.previous = nil
    end

    @size -= 1

    @tail = nil if @size == 0

    return deleted
  end

  # Define a "delete_last" method which takes no arguments. This method should
  # delete the last item in the list and return the value of that item. The size
  # must be reduced by 1. An IndexError should be raised if the list is empty.

  def delete_last
    raise IndexError, "List is empty" if size == 0

    deleted = @tail.value

    @tail = @tail.previous

    if @tail
      @tail.child = nil
    end

    @size -= 1

    @head = nil if @size == 0

    return deleted
  end

  # Define an "each" method which takes no arguments but accepts a block. The
  # block is yielded to with each element in the list, in order. The return
  # value must be self.

  def each
    currentNode = @head

    while currentNode
      yield currentNode.value
      currentNode = currentNode.child
    end

    return self
  end

  # Define an "each_reversed" method which takes no arguments but accepts a
  # block. The block is yielded to with each element in the list, in reverse
  # order. The return value must be self.

  def each_reversed
    currentNode = @tail

    while currentNode
      yield currentNode.value
      currentNode = currentNode.previous
    end

    return self
  end

  private

  def check_bounds(index)
    check_lower_bound(index)
    check_upper_bound(index)
  end

  def check_lower_bound(index)
    raise IndexError, "Invalid index: #{index}" if index < 0
  end

  def check_upper_bound(index)
    raise IndexError, "Invalid index: #{index}" if index >= size
  end
end
