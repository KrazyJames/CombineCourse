import Combine
import SwiftUI
import PlaygroundSupport

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

struct MyView: View {
    @State private var posts = [Post]()
    @State private var cancellable: AnyCancellable?

    var body: some View {
        NavigationView {
            List(posts) { post in
                Text(post.title)
            }
            .navigationTitle("Simple view")
        }
        .onAppear {
            cancellable = getPosts(
                string: "https://jsonplaceholder.typicode.com/posts"
            )
            .catch { _ in
                Just([Post]())
            }
            .assign(
                to: \.posts,
                on: self
            )
        }
    }

    func getPosts<T: Decodable>(
        string: String
    ) -> AnyPublisher<T, Error> {
        guard let url = URL(
            string: string
        ) else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(
            for: url
        ).map { data, response in
            return data
        }
        .decode(
            type: T.self,
            decoder: JSONDecoder()
        )
        .receive(
            on: RunLoop.main
        )
        .eraseToAnyPublisher()
    }
}

PlaygroundPage.current.setLiveView(MyView())
