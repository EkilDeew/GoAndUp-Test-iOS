//
//  Episodes.swift
//  GoAndUp
//
//  Created by Guillaume Fourrier on 26/02/2021.
//

import Foundation

struct ContentImage: Decodable {
    let medium: String
    let original: String
    
    var mediumUrl: URL? {
        URL(string: medium)
    }
    
    var originalUrl: URL? {
        URL(string: original)
    }
}

struct Episode: Decodable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let image: ContentImage
    let summary: String
}
