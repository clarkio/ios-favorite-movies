//
//  SearchViewController.swift
//  Favorite Movies
//
//  Created by Brian on 12/10/16.
//  Copyright © 2016 bc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: ViewController!
    var searchResults: [Movie] = []
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func search(sender: UIButton) {
        print("Searching for \(self.searchText.text!)")
        
        var searchTerm = searchText.text!
        if searchTerm.characters.count > 2 {
            retrieveMoviesByTerm(searchTerm: searchTerm)
        }
    }
    
    @IBAction func addFav (sender: UIButton) {
        print("Item #\(sender.tag) was selected as a favorite")
        self.delegate.favoriteMovies.append(searchResults[sender.tag])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // grouped vertical sections of the tableview
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // at init/appear ... this runs for each visible cell that needs to render
        let moviecell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomTableViewCell
        
        let idx: Int = indexPath.row
        moviecell.favButton.tag = idx
        
        //title
        moviecell.movieTitle?.text = searchResults[idx].title
        //year
        moviecell.movieYear?.text = searchResults[idx].year
        // image
        displayMovieImage(idx, moviecell: moviecell)
        
        return moviecell
    }
    
    func displayMovieImage(_ row: Int, moviecell: CustomTableViewCell) {
        let url: String = (URL(string: searchResults[row].imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                moviecell.movieImageView?.image = image
            })
        }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveMoviesByTerm(searchTerm: String) {
        let url = "https://www.omdbapi.com/?apikey=PlzBanMe&s=\(searchTerm)&type=movie&r=json"
        HTTPHandler.getJson(urlString: url, completionHandler: parseDataIntoMovies)
    }
    
    func parseDataIntoMovies(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parse(data: data)
            if let object = object {
                self.searchResults = MovieDataProcessor.mapJsonToMovies(object: object, moviesKey: "Search")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
