import Combine

// MARK: - Min and Max
// They practically return you the minimum and maximum object of a sequence

let sequence = [1,2,3,4,5].shuffled()
let publisher = sequence.publisher

publisher.min().sink { value in
    print(value)
}

publisher.max().sink { value in
    print(value)
}

// MARK: - First and Last
// Names are pretty descriptive tho, and you could pass a predicate or condition

publisher.first().sink { value in
    print(value)
}

// If you had [2,1,4,3,5] sequence, it would print 3 since 5 (the very last element) is greater than 4
publisher.last(where: { $0 < 4 }).sink { value in
    print(value)
}

// MARK: - Output at
// Basically asks for a position or range of positions

publisher.output(at: 0).sink { value in
    print(value)
}

publisher.output(in: (0...3)).sink { sequence in
    print(sequence)
}

// MARK: - Count
// Gets the number of items in the publisher onece the publisher reached the completion state
publisher.count().sink { count in
    print(count)
}

let pub = PassthroughSubject<Int, Never>()
pub.count().sink { count in
    print(count)
}
pub.send(30) // Just 1 element in total
pub.send(completion: .finished)

// MARK: - Contains
// Checks if there is any of the asked value

publisher.contains(10).sink { contains in
    print(contains)
}

// MARK: - All Satisfy
// Given a predicate, asks if ALL the elements satisfies it

publisher.allSatisfy { value in
    value.isMultiple(of: 2)
}.sink { allEven in
    print(allEven)
}

// MARK: - Reduce
// Reduces the sequence to one element given a partial result (how to reduce) and the initial value

publisher.reduce(0) { accumulator, value in
    print(accumulator, value)
    return accumulator + value
} .sink { value in
    print(value)
}
