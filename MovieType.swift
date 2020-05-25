//
//  MovieType.swift
//  MovieInfo
//
//  Created by User on 2020/05/19.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct Search: Codable {
    var Search: [Movie]
}

struct Movie: Codable {
    let Title:String
    let Year:String
    let imdbID: String
    let type: String
    var Poster: String = ""
    
    enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, Poster // not write other variable
        case type = "Type"
        // type instead of Type
    }
}
