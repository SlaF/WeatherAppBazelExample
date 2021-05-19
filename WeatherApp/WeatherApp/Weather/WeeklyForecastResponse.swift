//
//  WeeklyForecastResponse.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 14.05.2021.
//

import Foundation

struct WeeklyForecastResponse: Codable {
    
    let list: [Item]
    
    struct Item: Codable {
        let weather: [Weather]
        let main: MainClass
        let date: Date
        
        enum CodingKeys: String, CodingKey {
            case weather
            case main
            case date = "dt"
        }
    }
    
    struct Weather: Codable {
        let main: MainEnum
        let weatherDescription: String
        
        enum CodingKeys: String, CodingKey {
            case main
            case weatherDescription = "description"
        }
    }
    
    struct MainClass: Codable {
        let temp: Double
    }
    
    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
    
}
