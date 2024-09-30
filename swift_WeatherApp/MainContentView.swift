//
//  MainContentView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI

struct MainContentView: View {
    var day: WeatherDay
    var isNight: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: isNight ? "moon.stars.fill" : day.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 150)
            
            if let temperature = day.temperature {
                Text("\(temperature)°")
                    .font(.system(size: 70, weight: .medium))
                    .foregroundColor(.white)
            }
            
            Text(day.dayOfWeek)
                .font(.title2)
                .foregroundColor(.white)
            
            if let highTemp = day.highTemp, let lowTemp = day.lowTemp {
                Text("H: \(highTemp)° L: \(lowTemp)°")
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
        .padding(.all)
        .background(Color.black.opacity(0.1))
        .cornerRadius(15)
    }
}

