//
//  Requests.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import Foundation
import Alamofire

struct Request {
    
    var urlSession = URLSession.shared
    
    static func searchMovie(input: SearchMovieInput, complete: @escaping ([MovieModel])->()) {
        AF.request(URLs.DOMAIN, parameters: input)
            .validate()
            .responseDecodable(of: SearchMovieResult.self) { response in
                guard let searchResult = response.value else {
                    return
                }
                complete(searchResult.search)
            }
    }
    
}
