//
//  WeatherDay.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import Foundation

struct WeatherDay: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
}

class WeatherData: ObservableObject {
    @Published var weatherDays: [WeatherDay] = [
        WeatherDay(dayOfWeek: "WED", imageName: "cloud.sun.rain", temperature: 58),
        WeatherDay(dayOfWeek: "WED", imageName: "cloud.sun.rain", temperature: 58),
        WeatherDay(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 64),
        WeatherDay(dayOfWeek: "THU", imageName: "wind.snow", temperature: 54),
        WeatherDay(dayOfWeek: "FRI", imageName: "cloud.sun.rain.fill", temperature: 65),
        WeatherDay(dayOfWeek: "SAT", imageName: "cloud.sun.bolt.fill", temperature: 64),
        WeatherDay(dayOfWeek: "SUN", imageName: "snow", temperature: 48),
    ]
}
