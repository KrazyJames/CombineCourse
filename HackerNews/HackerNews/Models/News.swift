//
//  News.swift
//  HackerNews
//
//  Created by jescobar on 3/10/22.
//

import Foundation

struct News: Decodable {
    let id: Int
    let title: String
    let url: String
}
