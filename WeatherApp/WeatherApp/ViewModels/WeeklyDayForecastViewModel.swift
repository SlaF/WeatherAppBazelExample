//
//  WeeklyDayForecastViewModel.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 14.05.2021.
//

import Foundation

struct WeeklyDayForecastViewModel: Identifiable {
    
    private let item: WeeklyForecastResponse.Item
    
    var id: String {
        day + temperature + title
    }
    
    var day: String {
        dayFormatter.string(from: item.date)
    }
    
    var month: String {
        monthFormatter.string(from: item.date)
    }
    
    var temperature: String {
        return String(format: "%.1f", item.main.temp)
    }
    
    var title: String {
        guard let title = item.weather.first?.main.rawValue else { return "" }
        return title
    }
    
    var fullDescription: String {
        guard let description = item.weather.first?.weatherDescription else { return "" }
        return description
    }
    
    init(item: WeeklyForecastResponse.Item) {
        self.item = item
    }
    
}
