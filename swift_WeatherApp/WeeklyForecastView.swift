//
//  WeeklyForecastView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI

struct WeeklyForecastView: View {
    var weeklyForecast: [String :[WeatherDay]]
    @Binding var selectedDay: WeatherDay?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(weeklyForecast["day"] ?? []) { day in // Accessing the "day" array
                    VStack {
                        Text(day.dayOfWeek)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(day.isNight == true ? .blue : .white)
                        
                        Image(systemName: day.imageName)
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        if let temperature = day.temperature {
                            Text("\(temperature)°")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(day.isNight == true ? .blue : .white)
                        }
                        
                        // Add a Text view for night temperature and icon
                        if let night = weeklyForecast["night"]?.first(where: { $0.dayOfWeek == day.dayOfWeek }) {
                            Image(systemName: night.imageName)
                                .symbolRenderingMode(.multicolor)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)

                            if let nightTemperature = night.temperature {
                                Text("\(nightTemperature)° Night")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
                    .background(day.id == selectedDay?.id ? Color.white.opacity(0.2) : Color.clear)
                    .cornerRadius(10)
                    .onTapGesture {
                        selectedDay = day
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

