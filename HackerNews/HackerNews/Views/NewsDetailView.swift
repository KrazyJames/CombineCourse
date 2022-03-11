//
//  NewsDetailView.swift
//  HackerNews
//
//  Created by jescobar on 3/10/22.
//

import SwiftUI

struct NewsDetailView: View {
    let viewModel: NewsViewModel

    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.title)
            WebView(url: viewModel.url)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(viewModel: .init(news: .init(id: 8833, title: "", url: "")))
    }
}
