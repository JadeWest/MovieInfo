//
//  ViewController.swift
//  MovieInfo
//
//  Created by User on 4/16/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class ViewController
    :UIViewController
{
    var numberOfCell: Int = 0
    let cellIdentifier: String = "cell"
    let encoder = JSONEncoder()
    var sortedMovie: [Movie] = []
    @IBOutlet weak var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getMovies()
        // datasource 없음
        // Don't have datasource in this code.
    }
    
    // MARK: - HTTP Request Area
    func getMovies() {
        guard let resourceURL = URL(string: "http://www.omdbapi.com/?s=batman&apikey=5443ae87") else {return}
        var request = URLRequest(url: resourceURL)
        request.httpMethod = "get"
        
        let decoder = JSONDecoder()
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response:URLResponse?, error: Error?) in
            
            if let _:Error = error { return }
            
            guard let data:Data = data else { return }
            
            do {
                let movieList = try decoder.decode(Search.self, from: data)
                self.sortedMovie = movieList.Search.sorted {$0.Year < $1.Year}
  
                DispatchQueue.main.async {
                    self.numberOfCell = self.sortedMovie.count
                    
                    self.collectionView.reloadData()
                                    }
            } catch {
                print(error.localizedDescription)
                print("Not found movie data")
            }
            
        })
        task.resume()
    }
}
