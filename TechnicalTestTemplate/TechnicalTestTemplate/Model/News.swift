//
//  News.swift
//  TechnicalTestTemplate
//
//  Created by Dimas Syuhada on 28/05/22.
//

import Foundation

struct NewsData: Decodable {
    var author: String?
    var title: String?
    var urlToImage: String
    
}

struct News: Decodable {
    var articles: [NewsData]
}
