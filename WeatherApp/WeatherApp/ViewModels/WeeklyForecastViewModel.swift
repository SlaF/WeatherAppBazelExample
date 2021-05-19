//
//  WeeklyForecastViewModel.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 14.05.2021.
//

import Foundation
import SwiftUI
import Combine

class WeeklyForecastViewModel: ObservableObject {
    
    @Published var city = ""
    @Published var dataSource = [WeeklyDayForecastViewModel]()
    
    private let weatherFetcher: WeatherFetcher
    private var disposables = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetcher) {
        self.weatherFetcher = weatherFetcher
        
        $city
            .dropFirst()
            .sink(receiveValue: fetchForecast(for:))
            .store(in: &disposables)
    }
    
    private func fetchForecast(for city: String) {
        weatherFetcher.fetchWeeklyForecast(for: city)
            .map {
                $0.list.map(WeeklyDayForecastViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    
                    switch value {
                    case .failure(let error):
                        print(error)
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] forecast in
                    guard let self = self else { return }
                    self.dataSource = forecast
                }
            )
            .store(in: &disposables)
    }
    
}

extension WeeklyForecastViewModel {
    
    var currentWeatherView: some View {
        return WeeklyForecastDetailsView(
            viewModel: .init(
                city: city,
                weatherFetcher: weatherFetcher
            )
        )
    }
    
}
