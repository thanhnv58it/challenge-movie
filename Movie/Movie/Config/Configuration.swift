//
//  Configuration.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import Foundation

struct Configuration {
    
    enum Keys: String {
        case apiKey = "Movie API key"
    }
    
    static func infoForKey(_ key: Keys) -> String? {
        return (Bundle.main.infoDictionary?[key.rawValue] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
}
