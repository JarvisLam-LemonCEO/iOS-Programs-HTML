//
//  ModelData.swift
//  WeatherApp
//
//  Created by Jarvis Lam on 1/3/22.
//

import Foundation

var previewWeather: ResponseBody = load("weatherData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't ;oad \(filename) from main bundle:\n \(error)")
    }
    
    do {
        let deocder = JSONDecoder()
        return try deocder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
