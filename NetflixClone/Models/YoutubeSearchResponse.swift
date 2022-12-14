//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Takahide Sato on 11/4/22.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
