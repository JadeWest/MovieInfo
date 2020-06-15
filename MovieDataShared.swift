//
//  MovieDataShared.swift
//  MovieInfo
//
//  Created by User on 2020/05/22.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

class MovieInformation {
    static let movieShared: MovieInformation = MovieInformation()
    
    var imdbID: String?
    var searchText: String?
}
