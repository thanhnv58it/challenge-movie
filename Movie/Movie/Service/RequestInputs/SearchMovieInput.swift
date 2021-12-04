//
//  SearchMovieInput.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import Foundation

struct SearchMovieInput: Encodable {
    let apiKey = Configuration.infoForKey(.apiKey)
    let s: String
    let type = "movie"
    let page: Int
    
    init(query: String, page: Int) {
        self.s = query
        self.page = page
    }
}
