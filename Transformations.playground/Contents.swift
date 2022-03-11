import Combine
import Foundation

// MARK: - Collect
// Collects all the values if you dont define how many of them you want (as chunks)

let howMany = 2
["A", "B", "C", "D", "E"].publisher.collect(howMany).sink { array in
    print(array)
}
/* This prints
["A", "B"]
["C", "D"]
["E"]
 */

// MARK: - Map
// The well known mapping operator which transforms an array of values into other types
// ([A]) -> [B]

let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

[1, 2, 3].publisher.map { number in
    formatter.string(from: .init(value: number)) ?? ""
}.sink { str in
    print(str)
}

// MARK: - Map KeyPath
// Will allow you to access to certain keypaths or properties that may have the object you are dealing with

struct Point {
    let x: Int
    let y: Int
}
let publisher = PassthroughSubject<Point, Never>()
publisher.map(\.x, \.y).sink { x, y in
    print("(\(x), \(y))")
}
publisher.send(.init(x: 12, y: 10))

// MARK: - Flat map

struct School {
    let name: String
    let students: CurrentValueSubject<Int, Never>

    init(name: String, students: Int) {
        self.name = name
        self.students = .init(students)
    }
}

let school = School(name: "City School", students: 67)

let currentSchool = CurrentValueSubject<School, Never>(school)

currentSchool.sink { school in
    print(school)
}
// This wont trigger the update to currentSchool because we are listening to currentSchool's whole School change, not its individual or internal subjects
school.students.value += 1
// But if we access with the flatMap internally to the events of students, we get the change notification and we could print them
currentSchool.flatMap { current in
    current.students
}.sink { students in
    print(students)
}


// MARK: - Replace Nil
// This will replace any Nil inside a collection
["X", "Y", "Z", nil].publisher.replaceNil(with: "+").sink { optionalString in
    print(optionalString)
}

// MARK: - Challenge: Unwrap the Optional value received using replaceNil operation
["X", "Y", "Z", nil].publisher.replaceNil(with: "+").map { optionalString in
        optionalString! // It's ok use force unwrapping since you already replaced all nil values with "+"
    }
    .sink { str in
        print(str)
    }

// MARK: - Replace Empty
// This only use an empty transformation to not pass the value, it just completes
let empty = Empty<Int, Never>()

empty.sink { value in
    print(value)
}
// You could replace empty with some value
empty.replaceEmpty(with: 1).sink { value in
    print(value)
}
// MARK: - Scan
//

let pub = (1...10).publisher
pub.scan([]) { numbers, value -> [Int] in
    numbers + [value]
}.sink { ints in
    print(ints)
}
