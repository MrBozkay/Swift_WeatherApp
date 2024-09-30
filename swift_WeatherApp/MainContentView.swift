//
//  MainContentView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI

struct MainContentView: View {
    var day: WeatherDay
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: day.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(day.temperature ?? 0)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
            
            Text(day.dayOfWeek)
                .font(.title2)
                .foregroundColor(.white)
            
            Text("H: \(day.highTemp ?? 0)° L: \(day.lowTemp ?? 0)°")
                .font(.title3)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(15)
    }
}