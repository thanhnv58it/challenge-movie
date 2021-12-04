//
//  MovieModel.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import Foundation


// MARK: - MovieDetails
struct SearchMovieResult: Codable {
    let search: [MovieModel]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}


struct MovieModel: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    var posterURL: URL? {
        return URL(string: poster)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
        
        case imdbID
    }
}
