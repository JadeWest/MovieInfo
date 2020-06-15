//
//  CustomMovieCell.swift
//  MovieInfo
//
//  Created by User on 2020/05/21.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class CustomMovieCell:UICollectionViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    var omdbId: String?
    
}
