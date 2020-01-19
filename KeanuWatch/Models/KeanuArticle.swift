//
//  KeanuArticle.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/19/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation

struct KeanuArticle: Codable {
    var author: String
    var content: String?
    var description: String
    var publishedAt: String
    var source: KeanuArticleSource
    var title: String
    var url: String
    var urlToImage: String?
}

struct KeanuArticleSource: Codable {
    var id: String?
    var name: String
}

struct KeanuResults: Codable {
    var articles: [KeanuArticle]
    var status: String
    var totalResults: Int
}
