//
//  DetailViewController.swift
//  Favorite Movies
//
//  Created by Brian on 12/11/16.
//  Copyright © 2016 bc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie:Movie!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var plotTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Opening details for \(self.movie.title)")
        titleLabel!.text = self.movie.title
        getMovieDetails(movie: movie)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovieDetails(movie: Movie) {
        //http://www.omdbapi.com/?i=tt0215465&plot=short&r=json
        let url = "https://www.omdbapi.com/?i=\(movie.id)&plot=short&r=json"
        HTTPHandler.getJson(urlString: url, completionHandler: movieDetailsCompletion)
    }
    
    func movieDetailsCompletion (data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parse(data: data)
            if let object = object {
                guard let plot = object["Plot"] as? String else { return }
                DispatchQueue.main.async {
                    self.plotTextView.text = plot
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
