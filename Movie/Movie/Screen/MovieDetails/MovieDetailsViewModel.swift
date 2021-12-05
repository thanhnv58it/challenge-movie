//
//  MovieDetailsViewModel.swift
//  Movie
//
//  Created by Thành Ngô Văn on 05/12/2021.
//

import Foundation
import RxSwift
import RxRelay

class MovieDetailsViewModel {
    
    let relayLoading = BehaviorRelay<Bool>(value: false)
    let relayError = BehaviorRelay<String?>(value: nil)
    let relayMovieDetails = BehaviorRelay<MovieDetails?>(value: nil)

    let movie: MovieModel
    
    init(movie: MovieModel) {
        self.movie = movie
        getMovieDetails()
    }
    
    func getMovieDetails() {
        relayLoading.accept(true)
        let input = GetMovieDetailsInput(id: movie.imdbID)
        Request.sendRequest(input: input, outputType: MovieDetails.self) { [weak self] (details, error) in
            self?.relayLoading.accept(false)
            self?.relayMovieDetails.accept(details)
            self?.relayError.accept(error?.localizedDescription)
        }
    }
}
