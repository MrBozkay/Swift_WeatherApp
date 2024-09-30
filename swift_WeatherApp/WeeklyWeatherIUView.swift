//
//  WeeklyWeatherIUView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI

struct WeeklyWeatherIUView: View {
  
    @Binding var isNight: Bool
        
    let weekDays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    let weatherIcons = ["sun.max.fill", "cloud.sun.fill", "cloud.rain.fill", "cloud.bolt.fill", "wind", "snow", "sun.haze.fill"]
        
    var body: some View {
            VStack(spacing: 20) {
                ForEach(0..<7) { index in
                    HStack {
                        Text(weekDays[index])
                            .frame(width: 50, alignment: .leading)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        Image(systemName: weatherIcons[index])
                            .symbolRenderingMode(.palette)
                            .resizable()
                            .foregroundStyle(.white, .yellow, Color("lightblue"))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                        Text("\(Int.random(in: 50...80))°")
                            .frame(width: 50)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Color.black.opacity(0.2))
            .cornerRadius(10)
        }
    }


#Preview {
        WeeklyWeatherIUView(isNight: .constant(false))
            .background(Color.blue)
}

