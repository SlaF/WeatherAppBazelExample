//
//  WeeklyForecastDetailsView.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 15.05.2021.
//

import SwiftUI

struct WeeklyForecastDetailsView: View {
    
    private let viewModel: WeeklyForecastDetailsViewModel
    
    init(viewModel: WeeklyForecastDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if let viewModel = viewModel.dataSource {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("☀️ Temperature:")
                        Text("\(viewModel.temperature)°")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("📈 Max temperature:")
                        Text("\(viewModel.maxTemperature)°")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("📉 Min temperature:")
                        Text("\(viewModel.minTemperature)°")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("💧 Humidity:")
                        Text(viewModel.humidity)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
        }
    }
}
