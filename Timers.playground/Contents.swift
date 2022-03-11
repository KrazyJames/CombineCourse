import Combine
import Foundation

// MARK: - RunLoop

let runLoop = RunLoop.main

let sub = runLoop.schedule(after: runLoop.now, interval: .seconds(2), tolerance: .milliseconds(100)) {
    print("Timer fired")
}

runLoop.schedule(after: .init(.init(timeIntervalSinceNow: 3.0))) {
    sub.cancel()
}

// MARK: - Timer

let subs = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().scan(0, { counter, _ in
    counter + 1
}).sink { date in
    print(date)
}

// MARK: - DispatchQueue

let queue = DispatchQueue.main

let source = PassthroughSubject<Int, Never>()

var counter = 0

let cancellable = queue.schedule(after: queue.now, interval: .seconds(1)) {
    source.send(counter)
    counter += 1
}

let subscription = source.sink { value in
    print(value)
}
