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
    let relayLoading = BehaviorRelay<Bool>(value: false)

    private var didLoadAll = false
    private var currentPage = 1
    private var currentQuery = ""
    
    func searchMovie(query: String) {
        print("searchMovie \(query)")
        relayLoading.accept(true)
        currentQuery = query
        currentPage = 1
        
        let input = SearchMovieInput(query: query, page: currentPage)
        Request.searchMovie(input: input) { [weak self] (movies) in
            print(movies.count, " movies")
            self?.relaySearchData.accept(movies)
            self?.relayLoading.accept(false)
        }
    }
    
    func loadMoreData() {
        guard !relayLoading.value, !didLoadAll else {
            return
        }
        guard !currentQuery.isEmpty else {
            return
        }
        
        relayLoading.accept(true)
        currentPage = currentPage + 1
        let input = SearchMovieInput(query: currentQuery, page: currentPage)
        Request.searchMovie(input: input) { [weak self] (movies) in
            if movies.isEmpty {
                self?.didLoadAll = true
            } else {
                var current = self?.relaySearchData.value ?? []
                current.append(contentsOf: movies)
                self?.relaySearchData.accept(current)
                print(current.count, " movies")
            }
            self?.relayLoading.accept(false)
        }
    }
}
