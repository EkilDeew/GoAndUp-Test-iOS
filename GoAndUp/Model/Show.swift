//
//  Show.swift
//  GoAndUp
//
//  Created by Guillaume Fourrier on 26/02/2021.
//

import Foundation

struct Show: Decodable {
    let id: String
    let image: ContentImage
    let episodes: [Episode]
}
