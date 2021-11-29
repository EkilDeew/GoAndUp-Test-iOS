//
//  Service.swift
//  GoAndUp
//
//  Created by Guillaume Fourrier on 26/02/2021.
//

import Foundation

class Service {
    
    static func getEpisodes(_ completion: @escaping ([Episode]) -> Void) {
        let url = URL(string: "https://beta.goandup.paris/got.json")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("error geting show \(error.localizedDescription)")
                return
            }
            if let data = data {
                do {
                    // Just to filter out `_embedded` field
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let embedded = json["_embedded"] as? [String: Any],
                       let episodes = embedded["episodes"] as? [[String: Any]] {
                        let jsonData = try JSONSerialization.data(withJSONObject: episodes)
                        let episodesDecoded = try JSONDecoder().decode([Episode].self, from: jsonData)
                        completion(episodesDecoded)
                    }
                } catch {
                    debugPrint("Error \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
