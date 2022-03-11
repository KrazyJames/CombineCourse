//
//  NewsService.swift
//  HackerNews
//
//  Created by jescobar on 3/10/22.
//

import Foundation
import Combine

final class NewsService {

    func getTopNews() -> AnyPublisher<[News], Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else { fatalError("Invalid URL") }
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .flatMap({ ids in
                self.mergeNews(ids: ids)
            })
            .scan([], { list, news -> [News] in
                list + [news]
            })
            .eraseToAnyPublisher()
    }

    func getNewsBy(id: Int) -> AnyPublisher<News, Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty") else { fatalError("Invalid URL") }
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: News.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private func mergeNews(ids: [Int], max: Int = 50) -> AnyPublisher<News, Error> {
        let newsIds = Array(ids.prefix(max))
        let initialPub = getNewsBy(id: newsIds[0])
        let remainder = Array(ids.dropFirst())

        return remainder.reduce(initialPub) { partialResult, id in
            return partialResult.merge(with: getNewsBy(id: id))
                .eraseToAnyPublisher()
        }
    }

}
