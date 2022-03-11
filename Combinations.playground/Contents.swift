import Combine

// MARK: - Prepend
// Gonna add a sequence before other one

let numbers = (1...10).publisher
let numbers2 = (-10 ... -3).publisher

numbers
    .prepend(-1, 0)
    .prepend(-2)
    .prepend(numbers2)
    .sink { value in
    print(value)
}

// MARK: - Append
// Gonna add a sequence after other one

let numbers3 = (13...20).publisher
numbers
    .append(11, 12)
    .append(numbers3)
    .sink { value in
    print(value)
}

// MARK: - Switch to Latest
// Will switch to the latest publisher

let publisher1 = PassthroughSubject<String, Never>()
let publisher2 = PassthroughSubject<String, Never>()

let publishers = PassthroughSubject<PassthroughSubject<String, Never>, Never>()

publishers.switchToLatest().sink { word in
    print(word)
}

publishers.send(publisher1)
publisher1.send("Pub 1")
publishers.send(publisher2)
publisher2.send("Pub 2")
publisher1.send("Pub 1") // You wont receive it since publishers is switched to the latest (publisher2)

// MARK: - Merge
// Gonna merge different events form different publishers of the same type

let first = PassthroughSubject<Int, Never>()
let second = PassthroughSubject<Int, Never>()

first.merge(with: second).sink { number in
    print(number)
}

first.send(10)
second.send(11)

// MARK: - Combine latest
// Picks the latest value sent to the publisher and combine them into a tuple

let stringPub = PassthroughSubject<String, Never>()
let floatPub = PassthroughSubject<Float, Never>()

stringPub.combineLatest(floatPub).sink { str, float in
    print(str, "\(float)")
}

stringPub.send("a")
floatPub.send(1.1)
floatPub.send(2.2)

// MARK: - Zip
// Will group in a tuple the pair of values combined

let doublePub = PassthroughSubject<Double, Never>()
let intPub = PassthroughSubject<Int, Never>()

doublePub.zip(intPub).sink { double, int in
    print(double, int)
}
doublePub.send(3.3)
doublePub.send(4.4) // It will wait its partner
intPub.send(3)
