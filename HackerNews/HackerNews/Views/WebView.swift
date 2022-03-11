//
//  WebView.swift
//  HackerNews
//
//  Created by jescobar on 3/10/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL?

    func makeUIView(context: Context) -> WKWebView {
        guard let url = url else {
            return .pageNotFound()
        }
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {

    }
}

extension WKWebView {
    static func pageNotFound() -> WKWebView {
        let webView = WKWebView()
        webView.loadHTMLString("<html><body><h1>Page not found!</h1></body><html>", baseURL: nil)
        return webView
    }
}
