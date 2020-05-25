//
//  Movie.swift
//  MovieInfo
//
//  Created by User on 4/19/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct MovieInfo: Decodable {
    var title:String
    var released: Date
    var runtime: String
    var director: String
    var actors: String
    var ratings: [RatingInfo]
}

struct RatingInfo: Decodable {
    var source: String
    var value: String
}
