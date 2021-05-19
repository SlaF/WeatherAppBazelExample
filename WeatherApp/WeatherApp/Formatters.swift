//
//  Formatters.swift
//  WeatherApp
//
//  Created by Vyacheslav Redkin on 14.05.2021.
//

import Foundation

let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return formatter
}()

let monthFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter
}()
