//
//  WeatherDetailsView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 1.10.2024.
//

import SwiftUI




struct WeatherDetailsView: View {
    var day: WeatherDay
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let precipitation = day.precipitation {
                DetailRow(title: "Precipitation", value: "\(precipitation)%")
            }
            if let humidity = day.humidity {
                DetailRow(title: "Humidity", value: "\(humidity)%")
            }
            if let windSpeed = day.windSpeed {
                DetailRow(title: "Wind Speed", value: "\(windSpeed) mph")
            }
        }
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(15)
    }
}

//#Preview {
//    WeatherDetailsView()}
//}
