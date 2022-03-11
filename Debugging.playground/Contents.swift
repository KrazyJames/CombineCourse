import Combine
import Foundation

// MARK: - Printing events
let pub = (1...20).publisher

pub.print("Debugging").sink { number in
    print(number)
}

// MARK: - Action on events, with Side Effects
guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
    fatalError("Invalid url")
}

let request = URLSession.shared.dataTaskPublisher(for: url)

// You can use HandleEvents to get every step covered and see what went wrong
let sub = request.handleEvents(receiveSubscription: { _ in print("Subscription reveived") }, receiveOutput: { _, _ in print("received output") }, receiveCompletion: { completion in print(completion) }, receiveCancel: { print("Cancel") }, receiveRequest: { demand in print(demand)}).sink { completion in
    print(completion)
} receiveValue: { data, response in
    print(data)
}

// MARK: - Debugger

// In a real app this will stop the program's execution with a breakpoint when the condition is met
let cancellable = pub.breakpoint(receiveOutput: { value in
    return value > 9
}).sink { number in
    print(number)
}
