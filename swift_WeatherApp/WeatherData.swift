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
    let temperature: Int?
    let highTemp: Int?
    let lowTemp: Int?
    let precipitation: Int?
    let humidity: Int?
    let windSpeed: Int?
}

class WeatherData: ObservableObject {
    @Published var weeklyForecast: [WeatherDay] = [
        .init(dayOfWeek: "Today", imageName: "sun.max.fill", temperature: 72, highTemp: 75, lowTemp: 65, precipitation: 10, humidity: 45, windSpeed: 8),
        .init(dayOfWeek: "Tue", imageName: "cloud.sun.rain.fill", temperature: 68, highTemp: 70, lowTemp: 62, precipitation: 40, humidity: 65, windSpeed: 12),
        .init(dayOfWeek: "Wed", imageName: "cloud.bolt.rain.fill", temperature: 65, highTemp: 67, lowTemp: 60, precipitation: 80, humidity: 75, windSpeed: 15),
        .init(dayOfWeek: "Thu", imageName: "sun.max.fill", temperature: 70, highTemp: 73, lowTemp: 64, precipitation: 5, humidity: 40, windSpeed: 6),
        .init(dayOfWeek: "Fri", imageName: "cloud.sun.fill", temperature: 69, highTemp: 71, lowTemp: 63, precipitation: 20, humidity: 55, windSpeed: 10),
        .init(dayOfWeek: "Sat", imageName: "sun.max.fill", temperature: 74, highTemp: 76, lowTemp: 66, precipitation: 0, humidity: 35, windSpeed: 5),
        .init(dayOfWeek: "Sun", imageName: "cloud.sun.fill", temperature: 71, highTemp: 73, lowTemp: 65, precipitation: 15, humidity: 50, windSpeed: 7)
    ]
}
