package com.on_site.kamayan.collections;

import com.on_site.kamayan.Kamayan;

import java.util.function.Consumer;

public class DoublyLinkedList {
    private Node head;
    private Node tail;
    private int size;

    public DoublyLinkedList() {
        this.head = null;
        this.tail = null;
        this.size = 0;
    }

    // Use this nested class for storing the values of the
    // DoublyLinkedList. Each DoublyLinkedList.Node contains the value at its
    // index, and a link to the DoublyLinkedList.Node at the next index (called
    // the "child" here) and at the previous index (called "previous"). If the
    // child is null, that denotes the last element of the DoublyLinkedList,
    // while a null previous denotes the first.
    class Node {
        public Object value;
        public Node previous;
        public Node child;

        public Node(Object value) {
            this(value, null, null);
        }

        public Node(Object value, Node previous, Node child) {
            this.value = value;
            this.previous = previous;
            this.child = child;
        }
    }

    public int size() {
        return size;
    }

    public DoublyLinkedList prepend(Object value) {
        // throw Kamayan.todo(
        //     "The prepend(Object) method should prepend the argument to the",
        //     "beginning of this DoublyLinkedList and increase the size by 1. The",
        //     "return value must be this."
        // );

        head = new Node(value, null, head);

        if (head.child != null) {
            head.child.previous = head;
        } else {
            tail = head;
        }

        size ++;

        return this;
    }

    public DoublyLinkedList add(Object value) {
        // throw Kamayan.todo(
        //     "The add(Object) method should append the argument to the end of",
        //     "this DoublyLinkedList and increase the size by 1. The return value",
        //     "must be this."
        // );

        tail = new Node(value, tail, null);

        if (tail.previous != null) {
            tail.previous.child = tail;
        } else {
            head = tail;
        }

        size ++;

        return this;
    }

    public Object first() {
        // throw Kamayan.todo(
        //     "The first() method should return the value of the first item. An",
        //     "IndexOutOfBoundsException should be thrown if the list is empty."
        // );

        if (size == 0) {
            throw new IndexOutOfBoundsException("List is empty");
        }

        return head.value;
    }

    public Object last() {
        // throw Kamayan.todo(
        //     "The last() method should return the value of that item. An",
        //     "IndexOutOfBoundsException should be thrown if the list is empty."
        // );

        if (size == 0) {
            throw new IndexOutOfBoundsException("List is empty");
        }

        return tail.value;
    }

    public Object deleteFirst() {
        // throw Kamayan.todo(
        //     "The deleteFirst() method should delete the first item in the list",
        //     "and return the value of that item. The size must be reduced by 1.",
        //     "An IndexOutOfBoundsException should be thrown if the list is empty."
        // );

        if (size == 0) {
            throw new IndexOutOfBoundsException("List is empty");
        }

        Object deleted = head.value;

        head = head.child;

        if (head != null) {
            head.previous = null;
        } else {
            tail = null;
        }

        size -= 1;

        return deleted;
    }

    public Object deleteLast() {
        // throw Kamayan.todo(
        //     "The deleteLast() should delete the last item in the list and",
        //     "return the value of that item. The size must be reduced by 1. An",
        //     "IndexOutOfBoundsException should be thrown if the list is empty."
        // );

        if (size == 0) {
            throw new IndexOutOfBoundsException("List is empty");
        }

        Object deleted = tail.value;

        tail = tail.previous;

        if (tail != null) {
            tail.child = null;
        } else {
            head = null;
        }

        size -= 1;

        return deleted;
    }

    public DoublyLinkedList each(Consumer<Object> block) {
        // throw Kamayan.todo(
        //     "The each(Consumer) method yields to the consumer with each element",
        //     "in the list, in order. The return value must be this."
        // );

        Node currentNode = head;

        while (currentNode != null) {
            block.accept(currentNode.value);
            currentNode = currentNode.child;
        }

        return this;
    }

    public DoublyLinkedList eachReversed(Consumer<Object> block) {
        // throw Kamayan.todo(
        //     "The eachReversed(Consumer) method yields to the consumer with each",
        //     "element in the list, in reverse order. The return value must be",
        //     "this."
        // );

        Node currentNode = tail;

        while (currentNode != null) {
            block.accept(currentNode.value);
            currentNode = currentNode.previous;
        }

        return this;
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
}
