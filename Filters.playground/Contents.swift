import Combine
import Foundation

// MARK: - Filter
// Filters by a condition
let numbers = (1...20).publisher

numbers.filter { element in
    element % 2 == 0
}.sink { numbers in
    print(numbers)
}

// MARK: - Remove Duplicates
// It will remove duplicated values if they are in a row
let words = "apple apple fruit apple mango watermelon apple fruit".components(separatedBy: " ").publisher

words.removeDuplicates().sink { word in
    print(word)
}

// MARK: - Compact Map
// Remove the nil values from a sequence while mapping
let strings = ["a", "1", "b", "3.14", "0.6"].publisher.compactMap({ Float($0) }).sink { number in
    print(number)
}

// MARK: - Ignore Output
// Will ignore the output and emit the completion when done
let range = (1...500).publisher

range.ignoreOutput().sink { completion in
    print(completion)
} receiveValue: { range in
    print(range)
}

// MARK: - First
// Returns the first value given a condition/predicate or not
numbers.first { number in
    number % 2 == 0
}.sink { number in
    print(number)
}

// MARK: - Last
// The opposite of First, returns the last value given a predicate or not
numbers.last { number in
    number % 2 == 0
}.sink { number in
    print(number)
}

// MARK: - Drop First
// Removes the first value found given a predicate or quantity if exists and returns it
numbers.dropFirst(5).sink { remainingNumbers in
    print(remainingNumbers)
}

// MARK: - Drop while
// Will be dropping while the condition is met
numbers.drop { number in
    number < 10
}.sink { remainingNumbers in
    print(remainingNumbers)
}

// MARK: - Drop Until
// Will be dropping until the a Publisher's output is met
let taps = PassthroughSubject<Int, Never>()
let isReady = PassthroughSubject<Void, Never>()
taps.drop(untilOutputFrom: isReady).sink { tap in
    print(tap)
}

(1...10).forEach { number in
    taps.send(number)
    if number == 5 {
        isReady.send()
    }
}

// MARK: - Prefix
// Will limit the output if the value prefixes some condition
numbers.prefix(2).sink { prefixed in
    print(prefixed)
}

numbers.prefix { number in
    number < 3
}.sink { element in
    print(element)
}

// MARK: - Challenge: Filter all the things
/*
   Create an example that publishes a collection of numbers from 1 to 100, and use filtering operators to:
    1. Skip the first 50 values emitted
    2. Take the next 20 values ofter those 50
    3. Only print the even numbers

   Expected output (one element per line):
    52 54 56 58 60 62 64 66 68 70
*/
print("Challenge")
print("---------------------------")
let collection = (1...100).publisher
collection.dropFirst(50).prefix(20).filter { remaining in
    remaining.isMultiple(of: 2)
}.sink { number in
    print(number)
}
