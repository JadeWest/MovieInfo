//
//  SearchViewController+tableView.swift
//  MovieInfo
//
//  Created by User on 2020/06/09.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as? CustomTableCell else {return UITableViewCell()}
        let count:Int = self.movies.count
        
        if count > 0 {
            let movie:Movie = self.movies[indexPath.row]
            
            let posterKey = movie.imdbID as NSString
            var posterImage:UIImage?
                    
            if let savedPoster = self.posterCache.object(forKey: posterKey) {
                posterImage = savedPoster
            } else {
                posterImage = self.changeToImage(movie.Poster, posterKey)
            }
            
            DispatchQueue.main.async {
                cell.mainLabel.text = movie.Title
                cell.subLabel.text = movie.Year
                cell.poster.image = posterImage
                cell.omdbId = movie.imdbID
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count:Int = self.movies.count
        
        return count > 10 ? 10 : count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
