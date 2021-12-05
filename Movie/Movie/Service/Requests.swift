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
    
    static func sendRequest<T: Decodable, F: Encodable>(input: F, outputType: T.Type, complete: @escaping (T?, Error?)->()) {
        
        AF.request(URLs.DOMAIN, parameters: input)
            .validate()
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    print(error)
                }
                complete(response.value, response.error)
            }
    }

}
