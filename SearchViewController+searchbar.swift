//
//  SearchViewController+searchbar.swift
//  MovieInfo
//
//  Created by User on 2020/06/12.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    // call when text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("text : \(searchText)")
        if searchText.count == 0 {
            self.movies = []
            DispatchQueue.main.async {
                self.searchResult.reloadData()
            }
        } else {
            guard let url = URL(string: "http://www.omdbapi.com/?s=\(searchText )&apikey=5443ae87") else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "get"
            
            let decoder = JSONDecoder()
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response:URLResponse?, error: Error?) in
                if let _:Error = error {return}
                
                guard let data: Data = data else {return}
                guard let dataList = try? decoder.decode(Search.self, from: data) else {return}
                
                self.movies = dataList.Search
                
                DispatchQueue.main.async {
                    self.searchResult.reloadData()
                }
            })
            
            task.resume()
        }
        
        // API를 불러오고 제목, 연도, 포스터 띄우기
    }
}
