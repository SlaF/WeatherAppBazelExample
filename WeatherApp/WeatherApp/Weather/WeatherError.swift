//
//  WeatherError.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 14.05.2021.
//

import Foundation

enum WeatherError: Error {
    case network(description: String)
    case parsing(description: String)
}
