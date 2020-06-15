//
//  MovieDetailViewController.swift
//  MovieInfo
//
//  Created by User on 2020/05/27.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //    var posterSet: UIImage?
    var omdbId: String?
    var titleToSet: String?
    var omdbUrl: String?
    var posterImg:UIImage?
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieInfo: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.movieInfo.text = self.titleToSet
        self.moviePoster.image = posterImg
        
        getMovieDetail()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
//        setPoster()
    }
    
    func getMovieDetail() {
        print(self.omdbUrl)
        guard let url:URL = URL(string: self.omdbUrl ?? "omdbUrl is nil") else {return}
        print("url: \(url)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data:Data?, response:URLResponse?, error: Error?) in
            
            if let _:Error = error {return}
            
            guard let data: Data = data else {return}
            
            do {
                let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                
                DispatchQueue.main.async {
                    self.movieInfo.text = "\nTitle: \(self.titleToSet ?? "No Title")\n\(movieDetail.dataException())"
//                    self.movieInfo.text.append(
//                        """
//                        Title: \(self.titleToSet ?? "No Title")\n
//                        Released: \(movieDetail.Released)\n
//                        Runtime: \(movieDetail.Runtime)\n
//                        Genre: \(movieDetail.Genre)\n
//                        Director: \(movieDetail.Director)\n
//                        Writer: \(movieDetail.Writer)\n
//                        Actors: \(movieDetail.Actors)\n
//                        Plot: \(movieDetail.Plot)\n
//                        Country: \(movieDetail.Country)\n
//                        Awards: \(movieDetail.Awards)\n
//                        Ratings: \(movieDetail.Ratings[1].Source) -  \(movieDetail.Ratings[1].Value)\n
//                        """
//                    )
                    
                }
                
            } catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setPoster() {
        guard let url:URL = URL(string: self.omdbUrl ?? "omdbUrl is nil") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data:Data?, response:URLResponse?, error: Error?) in
            
            if let _:Error = error {return}
            
            guard let data: Data = data else {return}
            print(String(data: data, encoding: String.Encoding.utf8))
            do {
                let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                let imageUrl: String = movieDetail.Poster
                var image: UIImage? = UIImage(named: "test")
                
                
                if !imageUrl.contains("N/A") {
                    guard let url: URL = URL(string: imageUrl) else {return}
                    
                    do {
                        let imageData = try Data(contentsOf: url)
                        image = UIImage(data: imageData)
                    } catch {
                        print(error)
                    }
                }
                DispatchQueue.main.async {
                    self.moviePoster.image = image
                }
                
            } catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
