import Combine

// MARK: - Publishers and Subscribers
//class StringSubscriber: Subscriber {
//    typealias Input = String
//    typealias Failure = Never
//
//    func receive(subscription: Subscription) {
//        print("Subcription recieved!")
//        subscription.request(.max(3))
//    }
//
//    func receive(_ input: String) -> Subscribers.Demand {
//        print("Value receive", input)
//        return .none
//    }
//
//    func receive(completion: Subscribers.Completion<Never>) {
//        print("Completed!")
//    }
//
//}
//
//let publisher = ["A", "B", "C", "D", "E"].publisher
//let subscriber = StringSubscriber()
//publisher.subscribe(subscriber)

enum MyError: Error {
    case someError
}

class StringSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = MyError

    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }

    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
        return .none
    }

    func receive(completion: Subscribers.Completion<MyError>) {
        print("Completed")
    }

}

let subject = PassthroughSubject<String, MyError>()
let subscriber = StringSubscriber()
subject.subscribe(subscriber)
subject.send("A")
let secondSubscriber = StringSubscriber()
subject.subscribe(secondSubscriber)
subject.send("B")
let cancellable = subject.sink { completion in
    print("Completion sink")
} receiveValue: { value in
    print("sink", value)
}
subject.send("C")
cancellable.cancel()
subject.send("D")

// MARK: - Type Eraser
let publisher = PassthroughSubject<Int, Never>()
let erased = publisher.eraseToAnyPublisher()

// You can subscribe to it
// but you can not use the .send(_) method
// since the erased one do not know what kind of Publisher it is
let erasedCancellable = erased.sink { value in
    print(value)
}
publisher.send(2)

erasedCancellable.cancel()
publisher.send(3)
