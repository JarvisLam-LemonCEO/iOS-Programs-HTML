//
//  API-Manager.swift
//  IPLocationsApp
//
//  Created by Jarvis Lam on 4/11/22.
//

import Foundation
import SwiftUI

// http://api.ipify.org/?format=json
struct IP: Decodable {
    var ip: String
}

// https://ipinfo.io/\(ip)/geo
struct IPGeo: Decodable {
    var city: String
    var country : String
    var timezone: String
}

// https://ipapi.co/\(ip)/json/
struct IPCoordinates: Decodable {
    var latitude: Double
    var longitude: Double
}

class APIManher {
    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping(T) ->(), failure:@escaping(Error) -> ()){
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) {(data, response, error)in
            guard let data = data else {
                if let error = error {
                    failure(error)
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                failure(error)
            }
        }
        .resume()
    }
}
