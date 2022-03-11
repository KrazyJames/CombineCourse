//
//  NewsListView.swift
//  HackerNews
//
//  Created by jescobar on 3/10/22.
//

import SwiftUI
import WebKit

struct NewsListView: View {
    @StateObject private var viewModel = NewsListViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.news) { news in
                    NavigationLink("\(news.title)", destination: NewsDetailView(viewModel: news))
                }
            }
            .navigationTitle("Hacker News")
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
