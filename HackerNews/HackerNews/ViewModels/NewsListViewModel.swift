//
//  NewsListViewModel.swift
//  HackerNews
//
//  Created by jescobar on 3/10/22.
//

import Combine
import Foundation

final class NewsListViewModel: ObservableObject {
    @Published var news: [NewsViewModel] = []
    private var cancellable: AnyCancellable?

    init() {
        getNews()
    }

    func getNews() {
        cancellable = NewsService().getTopNews().map({ news in
            news.map(NewsViewModel.init)
        }).sink(receiveCompletion: { _ in }, receiveValue: { viewModels in
            self.news = viewModels
        })
    }

}

struct NewsViewModel: Identifiable {
    let news: News
    var id: Int {
        news.id
    }
    var title: String {
        news.title
    }
    var url: URL? {
        URL(string: news.url)
    }
}
