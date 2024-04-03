//
//  Movie.swift
//  ios101-lab5-flix1
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let overview: String
    let poster_path: String?
}
