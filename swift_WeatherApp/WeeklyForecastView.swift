//
//  WeeklyForecastView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI


struct WeeklyForecastView: View {
    var weeklyForecast: [WeatherDay]
    @Binding var selectedDay: WeatherDay
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(weeklyForecast) { day in
                    WeatherDayView(day: day, isSelected: day.id == selectedDay.id)
                        .onTapGesture {
                            withAnimation {
                                selectedDay = day
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    WeeklyForecastView(weeklyForecast: WeatherData().weeklyForecast, selectedDay: .constant(WeatherData().weeklyForecast[0]))
}
