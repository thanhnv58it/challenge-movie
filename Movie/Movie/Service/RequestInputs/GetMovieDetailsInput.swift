//
//  GetMovieDetailsInput.swift
//  Movie
//
//  Created by Thành Ngô Văn on 05/12/2021.
//

import Foundation

struct GetMovieDetailsInput: Encodable {
    let apiKey = Configuration.infoForKey(.apiKey)
    let i: String

    init(id: String) {
        self.i = id
    }
}
