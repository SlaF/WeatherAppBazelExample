//
//  WeeklyForecastDetailsViewModel.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 15.05.2021.
//

import Foundation
import Combine

class WeeklyForecastDetailsViewModel: ObservableObject {
    
    @Published var dataSource: CurrentWeatherRowViewModel?
    
    private let city: String
    private let weatherFetcher: WeatherFetcher
    private var disposables = Set<AnyCancellable>()
    
    init(city: String, weatherFetcher: WeatherFetcher) {
        self.city = city
        self.weatherFetcher = weatherFetcher
        
        weatherFetcher.currentForecast(for: city)
            .receive(on: DispatchQueue.main)
            .map {
                CurrentWeatherRowViewModel(item: $0)
            }
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = nil
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] weather in
                    self?.dataSource = weather
                }
            )
            .store(in: &disposables)
    }
    
}
