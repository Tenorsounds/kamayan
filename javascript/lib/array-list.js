"use strict";

var FixedArray = require("./fixed-array"),
    IndexError = require("./index-error");

function ArrayList() {
    this._array = new FixedArray(10);
    this._size = 0;
}

ArrayList.prototype.size = function() {
    return this._size;
};

ArrayList.prototype.get = function(index) {
    this._checkBounds(index);
    return this._array.get(index);
};

// Define a method "add" which takes a single argument. This method should
// append the argument to the end of this ArrayList and increase the size by
// 1. The return value must be this.

ArrayList.prototype.add = function(value) {
    if (this._size >= this._array.size()) {
        this._expandArray();
    }

    this._array.set(this._size, value);
    this._size += 1;
    return this;
};

// Define a method "prepend" which takes a single argument. This method should
// prepend the argument to the beginning of this ArrayList and increase the size
// by 1. The return value must be this.

ArrayList.prototype.prepend = function(value) {
    if (this._size >= this._array.size()) {
        this._expandArray(1);
    } else {
        this._shiftArray();
    }

    this._array.set(0, value);

    this._size += 1;
    return this;
};

// Define a "delete" method which takes a single index argument. This method
// should delete the value at the provided index and return it. The size should
// be 1 less than it was before this method was called. The index must be within
// the bounds of the ArrayList, or an IndexError should be thrown.

ArrayList.prototype.delete = function(index) {
    var result;

    this._checkBounds(index);
    result = this._array.get(index);
    this._size -= 1;

    for (var i = index; i < this._size; i++) {
        this._array.set(i, this._array.get(i+1));
    }

    this._array.set(this._size, null);
    return result;
};

// Define a method "set" which takes 2 arguments. This method should set the
// value at the index defined in the first argument such that list.get(index)
// will return the second argument.
//
// If the index is negative, an IndexError should be thrown.
//
// If the index is bigger than the current size of the _array, the _array should
// be replaced with a bigger FixedArray to fit the new index. All indexes
// between the former last element and the new index should be initialized with
// null. An additional buffer should be included in the new FixedArray (in case
// the array is grown more), though this is not required.
//
// The size after this method is called depends on the index provided. An
// existing index would not affect the size, but an index greater than the last
// index will add the difference to the size.
//
// This method should return the value that was previously in the given index,
// or null if that does not apply.

ArrayList.prototype.set = function(index, value) {
    var oldValue;

    this._checkLowerBound(index);

    while (this._array.size() <= index) {
        this._expandArray();
    }

    oldValue = this._array.get(index);

    this._array.set(index, value);

    if (index >= this._size) {
        this._size = index + 1;
    }

    return oldValue;
};

ArrayList.prototype._checkBounds = function(index) {
    this._checkLowerBound(index);
    this._checkUpperBound(index);
};

ArrayList.prototype._checkLowerBound = function(index) {
    if (index < 0) {
        throw new IndexError("Invalid index: " + index);
    }
};

ArrayList.prototype._checkUpperBound = function(index) {
    if (index >= this.size()) {
        throw new IndexError("Invalid index: " + index);
    }
};

ArrayList.prototype._shiftArray = function() {
    for (var i = this._size - 1; i >= 0; i--) {
        this._array.set(i+1, this._array.get(i));
    }
};

ArrayList.prototype._expandArray = function(shift) {
    if (shift == undefined) {
        shift = 0;
    }

    var newArray = new FixedArray(this._array.size() * 2);

    for (var i=0; i < this._size; i++) {
        newArray.set(i + shift, this._array.get(i));
    }

    this._array = newArray;
};

module.exports = ArrayList;
