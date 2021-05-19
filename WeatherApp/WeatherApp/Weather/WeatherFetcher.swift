//
//  WeatherFetcher.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 14.05.2021.
//

import Foundation
import Combine
import Alamofire
import Kingfisher

struct OpenWeatherAPI {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5"
    static let key = "cbb613f9355168bb5da276d51c4ae1e7"
}

final class WeatherFetcher {
    
    private let urlSession = URLSession.shared
    
    func fetchWeeklyForecast(for city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        return fetch(from: urlForWeeklyForecast(for: city))
    }
    
    func currentForecast(for city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError> {
        return fetch(from: urlForCurrentForecast(for: city))
    }
    
    private func fetch<T>(from url: URL?) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = url else {
          let error = WeatherError.network(description: "Couldn't create URL")
          return Fail(error: error).eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(data: pair.data)
            }
            .eraseToAnyPublisher()
    }
 
    private func decode<T: Decodable>(data: Data) -> AnyPublisher<T, WeatherError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        
        return Just(data)
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError { error in
                .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    private func urlForWeeklyForecast(for city: String) -> URL? {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/forecast"
        
        components.queryItems = [
          URLQueryItem(name: "q", value: city),
          URLQueryItem(name: "mode", value: "json"),
          URLQueryItem(name: "units", value: "metric"),
          URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        
        return components.url
    }
    
    private func urlForCurrentForecast(for city: String) -> URL? {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/weather"
        
        components.queryItems = [
          URLQueryItem(name: "q", value: city),
          URLQueryItem(name: "mode", value: "json"),
          URLQueryItem(name: "units", value: "metric"),
          URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        
        return components.url
    }
}
