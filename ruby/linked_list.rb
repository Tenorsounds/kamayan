class LinkedList
  attr_reader :size

  def initialize
    @head = nil
    @size = 0
  end

  # Use this nested class for storing the values of the LinkedList. Each
  # LinkedList::Node contains the value at its index, and a link to the
  # LinkedList::Node at the next index (called the "child" here). If the child
  # is nil, that denotes the last element of the LinkedList.
  class Node
    attr_accessor :value, :child

    def initialize(value, child = nil)
      @value = value
      @child = child
    end
  end

  # Define a method ">>" which takes a single argument. This method should
  # prepend the argument to the beginning of this LinkedList and increase the
  # size by 1. The return value must be self.

  def >>(value)
    node = Node.new(value, @head)
    @head = node
    @size += 1
    return self
  end

  # Define a method "<<" which takes a single argument. This method should
  # append the argument to the end of this LinkedList and increase the size by
  # 1. The return value must be self.

  def <<(value)
    node = Node.new(value)
    currentNode = @head

    if @head != nil
      while currentNode.child != nil
        currentNode = currentNode.child
      end

      currentNode.child = node

    else
      @head = node
    end

    @size += 1

    return self
  end

  # Define a "delete" method which takes a single index argument. This method
  # should delete the value at the provided index and return it. The size should
  # be 1 less than it was before this method was called. The index must be
  # within the bounds of the LinkedList, or an IndexError should be raised.

  def delete(index)
    check_bounds(index)

    if index == 0
      deleting = @head
      @head = @head.child
    else
      before = find_node(index - 1)
      deleting = before.child
      before.child = before.child.child
    end

    @size -= 1
    deleting.value
  end

  # Define a method "[]" which takes a single index argument. This method should
  # retrieve the value at the given index. The index must be within the bounds
  # of the LinkedList, or an IndexError should be raised.

  def [](index)
    check_bounds(index)
    find_node(index).value
  end

  # Define a method "[]=" which takes 2 arguments. This method should set the
  # value at the index defined in the first argument such that
  # linked_list[index] will return the second argument.
  #
  # If the index is negative, an IndexError should be raised.
  #
  # If the index is bigger than the current size of the linked list, the links
  # should be adjusted to fit the new index.  All indexes between the former
  # last element and the new index should be initialized with nil.
  #
  # The size after this method is called depends on the index provided. An
  # existing index would not affect the size, but an index greater than the last
  # index will add the difference to the size.

  def []=(index, value)
    check_lower_bound(index)
    self << nil while index >= size
    find_node(index).value = value
  end

  private

  def find_node(index)
    node = @head
    index.times {node = node.child }
    node
  end

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
