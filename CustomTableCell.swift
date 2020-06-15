//
//  customTableCell.swift
//  MovieInfo
//
//  Created by User on 2020/06/09.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    var omdbId: String?
}
