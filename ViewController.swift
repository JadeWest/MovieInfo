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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // datasource 없음
        // Don't have datasource in this code.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovies()
    }
    
    // MARK: - HTTP Request Area
    func getMovies() {
        let searchText = MovieInformation.movieShared.searchText
        guard let resourceURL = URL(string: "http://www.omdbapi.com/?s=\(searchText ?? "")&apikey=5443ae87") else {return}
        var request = URLRequest(url: resourceURL)
        request.httpMethod = "get"
        
        let decoder = JSONDecoder()
        let session = URLSession.shared
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response:URLResponse?, error: Error?) in
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            if let _:Error = error { return }
            
            guard let data:Data = data else { return }
            
            do {
                let movieList = try decoder.decode(Search.self, from: data)
                self.sortedMovie = movieList.Search.sorted {$0.Year < $1.Year}
                print(movieList)
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let cell: CustomMovieCell = sender as? CustomMovieCell else {return}
        // TODO: Image 에러남 URL로 다시 받아오던지 아니면 해결책 필요
        
        //        detailViewController.moviePoster.image = cell.moviePoster?.image ?? UIImage()
        //                MovieInformation.movieShared.imdbID = self.sortedMovie[row].imdbID
        
        print(cell.omdbId)
        let imdbId:String = cell.omdbId ?? "Not Found"
        
        MovieInformation.movieShared.imdbID = imdbId
        
        guard let detailViewController: MovieDetailViewController = segue.destination as? MovieDetailViewController else {return}
        detailViewController.titleToSet = cell.movieTitle?.text ?? ""
        detailViewController.omdbUrl =  "http://www.omdbapi.com/?i=\(imdbId)&plot=full&apikey=5443ae87"
    }
}
