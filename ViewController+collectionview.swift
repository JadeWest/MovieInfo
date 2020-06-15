//
//  ViewController+collectionview.swift
//  MovieInfo
//
//  Created by User on 2020/05/23.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
        // MARK: - set CollectionView Interface Area
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCell
    }
    
    //TODO: imagecaching 추가
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: CustomMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CustomMovieCell
            else { return UICollectionViewCell()}
        
        let row:Int = indexPath.row
        let imageUrl:String = self.sortedMovie[row].Poster
        var image:UIImage? = UIImage(named: "test")
        let posterKey = self.sortedMovie[row].imdbID as NSString
        let posterCache = NSCache<NSString, UIImage>()
        
//         response data has no poster
        if let cachedImage = posterCache.object(forKey: posterKey) {
            DispatchQueue.main.async {
                cell.moviePoster.image = cachedImage
            }
            return cell
        }
        if !imageUrl.contains("N/A") {
            guard let url:URL = URL(string: imageUrl) else { return UICollectionViewCell() }
            
            do {
                let imageData = try Data(contentsOf: url)
                image = UIImage(data: imageData)
                posterCache.setObject(image!, forKey: posterKey)
            } catch {
                print(error)
            }
        }
        // rendering
        DispatchQueue.main.async {
            cell.moviePoster.image = image
            cell.movieTitle.text = self.sortedMovie[row].Title
            cell.releaseYear.text = self.sortedMovie[row].Year
            cell.omdbId = self.sortedMovie[row].imdbID
        }
        return cell
    }
    
    // 셀과 셀 사이의 간격 조절(padding)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // 줄과 줄 사이(margin)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screen = collectionView.bounds
        // return CGSize(width: 50, height: 50)
        return CGSize(width: screen.width/3, height: screen.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
