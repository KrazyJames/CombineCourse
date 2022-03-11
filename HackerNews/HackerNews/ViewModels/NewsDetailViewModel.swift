//
//  NewsDetailViewModel.swift
//  HackerNews
//
//  Created by jescobar on 3/10/22.
//

import Foundation
import Combine

final class NewsDetailViewModel: ObservableObject {
    @Published private var news: News = News(id: .zero, title: "", url: "")

    var id: Int
    private var cancellable: AnyCancellable?

    var title: String {
        news.title
    }

    var url: URL? {
        URL(string: news.url)
    }

    init(id: Int) {
        self.id = id
        cancellable = NewsService().getNewsBy(id: id)
            .catch({ _ in
                Just(News(id: id, title: "Unavailable", url: ""))
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { news in
                self.news = news
            })
    }
}
