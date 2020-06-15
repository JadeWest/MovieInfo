//
//  SearchViewController.swift
//  MovieInfo
//
//  Created by User on 2020/05/22.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let cellIdentifier: String = "searchCell"
    let posterCache = NSCache<NSString, UIImage>()
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var movies:[Movie] = []
    private let defaultImage:UIImage? = UIImage(named: "test")
    
    @IBOutlet weak var searchResult: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKeyboardNotificationCenter()
        self.searchBar.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Protocol를 이용하여 delegate로 구현
        MovieInformation.movieShared.searchText = self.searchBar.text
        navigationController?.popViewController(animated: true)
    }
    
    func addKeyboardNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector:#selector(KeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func KeyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.tableView.contentInset = insets
            self.tableView.scrollIndicatorInsets = insets
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
    }
    
    
    func changeToImage(_ imageUrl: String, _ posterKey: NSString) -> UIImage? {
        if imageUrl.contains("N/A") {
            posterCache.setObject(defaultImage!, forKey: posterKey)
            return defaultImage
        }
        
        guard let url: URL = URL(string: imageUrl) else {return defaultImage}
        
        guard let imageData = try? Data(contentsOf: url) else {return defaultImage}
        let image = UIImage(data: imageData)
        posterCache.setObject(image!, forKey: posterKey)
        return image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let cell: CustomTableCell = sender as? CustomTableCell else {return}
        
        print("prepare omdb: \(cell.omdbId ?? "cell.omdbId is nil")")
        let omdbId:String = cell.omdbId ?? "omdbId is nil"
        
        MovieInformation.movieShared.imdbID = omdbId
        
        // 코드로 뷰컨 생성
        guard let detailViewController: MovieDetailViewController = segue.destination as? MovieDetailViewController else {
            print("error")
            return
        }

        detailViewController.posterImg = cell.poster.image
        detailViewController.titleToSet = cell.mainLabel.text
        detailViewController.omdbId = omdbId
        detailViewController.omdbUrl = "http://www.omdbapi.com/?i=\(omdbId)&plot=full&apiKey=5443ae87"
    }
}
