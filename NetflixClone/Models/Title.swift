//
//  Movie.swift
//  NetflixClone
//
//  Created by Takahide Sato on 10/6/22.
//

import Foundation

struct TitleResponse : Codable {
    let results: [Title]
}

struct Title : Codable {
    let id: Int
    let media: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
