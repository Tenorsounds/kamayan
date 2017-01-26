class FixedArray
  def initialize(size)
    @array = Array.new(size)
  end

  def [](index)
    check_bounds(index)
    @array[index]
  end

  def []=(index, value)
    check_bounds(index)
    @array[index] = value
  end

  def size
    @array.size
  end

  def each
    index = 0

    while index < @array.size
      yield @array[index]
      index += 1
    end

    return self
  end

  private

  def check_bounds(index)
    raise IndexError, "Invalid index: #{index}" if index < 0 || index >= size
  end
end
