package com.on_site.kamayan.collections;

import com.on_site.kamayan.Kamayan;

public class ArrayList {
    private Object[] array;
    private int size;

    public ArrayList() {
        array = new Object[10];
        size = 0;
    }

    public int size() {
        return size;
    }

    public Object get(int index) {
        checkBounds(index);
        return array[index];
    }

    public ArrayList add(Object value) {
        if (size >= array.length) {
            expandArray();
        }

        array[size] = value;

        size += 1;
        return this;
    }

    public ArrayList prepend(Object value) {
        if (size >= array.length) {
            expandArray(1);
        } else {
            shiftArray();
        }

        array[0] = value;

        size += 1;
        return this;
    }

    public Object set(int index, Object value) {
        checkLowerBound(index);

        while (array.length <= index) {
            expandArray();
        }

        Object oldValue = array[index];

        array[index] = value;

        if (index >= size) {
            size = index + 1;
        }

        return oldValue;
    }

    public Object delete(int index) {
        checkBounds(index);
        Object result = array[index];
        size -= 1;

        for (int i=index; i<size; i++) {
            array[i] = array[i+1];
        }

        array[size] = null;
        return result;
    }

    private void checkBounds(int index) {
        checkLowerBound(index);
        checkUpperBound(index);
    }

    private void checkLowerBound(int index) {
        if (index < 0) {
            throw new IndexOutOfBoundsException("Invalid index: " + index);
        }
    }

    private void checkUpperBound(int index) {
        if (index >= size()) {
            throw new IndexOutOfBoundsException("Invalid index: " + index);
        }
    }

    private void shiftArray() {
        for (int i=size; i>=1; i--) {
            array[i] = array[i-1];
        }
    }

    private void expandArray(int shift) {
        Object[] newArray = new Object[array.length * 2];

        for (int i=0; i <= size-1; i++) {
            newArray[i + shift] = array[i];
        }

        array = newArray;
    }

    private void expandArray() {
        expandArray(0);
    }
}
