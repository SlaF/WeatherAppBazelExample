//
//  CurrentWeatherForecastResponse.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 15.05.2021.
//

struct CurrentWeatherForecastResponse: Decodable {
    
    let coord: Coord
    let main: Main
    
    struct Main: Decodable {
        let temperature: Double
        let humidity: Int
        let maxTemperature: Double
        let minTemperature: Double
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case humidity
            case maxTemperature = "temp_max"
            case minTemperature = "temp_min"
        }
    }
    
    struct Coord: Decodable {
        let lon: Double
        let lat: Double
    }
    
}
