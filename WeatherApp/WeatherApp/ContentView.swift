//
//  ContentView.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 14.05.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeeklyForecastViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("City ", text: $viewModel.city)
                .padding()
                
                if !viewModel.dataSource.isEmpty {
                    NavigationLink(destination: viewModel.currentWeatherView) {
                        Text("Details")
                    }
                }
                
                List {
                    Section {
                        ForEach(viewModel.dataSource) { row in
                            rowView(viewModel: row)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Weather ⛅️")
            }
        }
    }
    
    func rowView(viewModel: WeeklyDayForecastViewModel) -> some View {
          HStack {
            VStack {
              Text("\(viewModel.day)")
              Text("\(viewModel.month)")
            }
            
            VStack(alignment: .leading) {
              Text("\(viewModel.title)")
                .font(.body)
              Text("\(viewModel.fullDescription)")
                .font(.footnote)
            }
              .padding(.leading, 8)

            Spacer()

            Text("\(viewModel.temperature)°")
              .font(.title)
          }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeeklyForecastViewModel(weatherFetcher: .init()))
    }
}
