//
//  MovieListViewModel.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import Foundation
import RxSwift
import RxRelay

class MovieListViewModel {
    
    let relaySearchData = BehaviorRelay<[MovieModel]>(value: [])
    
    func searchMovie(query: String) {
        let input = SearchMovieInput(query: query, page: 1)
        Request.searchMovie(input: input) { [weak self] (movies) in
            print(movies.count, " movies")
            self?.relaySearchData.accept(movies)
        }
    }
}
