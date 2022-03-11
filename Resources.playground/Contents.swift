import Combine
import Foundation

let subject = PassthroughSubject<Data, URLError>()

// MARK: - Share
// It will share the subscription for all the insances in order to save resources since it will not request nth times

guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { fatalError("Invalid URL") }

//let request = URLSession.shared.dataTaskPublisher(for: url).map(\.data).print().share()
let request = URLSession.shared.dataTaskPublisher(for: url).map(\.data).print().multicast(subject: subject)

let sub1 = request.sink { completion in
    print(completion)
} receiveValue: { value in
    print("Sub 1")
    print(value)
}

let sub2 = request.sink { _ in
} receiveValue: { value in
    print("Sub 2")
    print(value)
}

// MARK: - Multicast
// Replays the last value of a request for a future subscription

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    _ = request.sink { _ in
    } receiveValue: { value in
        print("Sub 3")
        print(value)
    }
}

request.connect()
subject.send(.init())
