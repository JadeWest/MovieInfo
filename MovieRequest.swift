//
//  MovieRequest.swift
//  MovieInfo
//
//  Created by User on 4/19/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct MovieRequest {
    let resourceURL: URL
    let API_KEY = "http://www.omdbapi.com/?apikey=5443ae87&"
    
    let resourceString = "http://www.omdbapi.com/?t=\()&apikey=5443ae87"
    
}
