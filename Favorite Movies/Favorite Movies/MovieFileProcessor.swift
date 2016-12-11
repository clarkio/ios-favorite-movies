//
//  MovieFileProcessor.swift
//  Favorite Movies
//
//  Created by Brian on 12/10/16.
//  Copyright © 2016 bc. All rights reserved.
//

import Foundation

class MovieFileProcessor {
    static func read(fileName: String) -> [Movie] {
        // The file must be JSON
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        {
            if let data = NSData(contentsOf: url)
            {
                let object = JSONParser.parse(data: data as Data)
                if let dictionary = object {
                    return mapJsonToMovies(object: dictionary, moviesKey: "movies")
                }
            }
        }
        
        return []
    }
    
    static func mapJsonToMovies(object: [String: AnyObject], moviesKey: String) -> [Movie] {
        var mappedMovies: [Movie] = []
        
        guard let movies = object[moviesKey] as? [[String: AnyObject]] else { return mappedMovies }
        
        for movie in movies {
            guard let id = movie["imdbID"] as? String,
                let name = movie["Title"] as? String,
                let year = movie["Year"] as? String,
                let imageUrl = movie["Poster"] as? String else { continue }
            
            let movieClass = Movie(id: id, title: name, year: year, imageUrl: imageUrl)
            mappedMovies.append(movieClass)
        }
        return mappedMovies
    }
    
    static func write(movies: [Movie]) {
        // TODO: Implement :)
    }
}
