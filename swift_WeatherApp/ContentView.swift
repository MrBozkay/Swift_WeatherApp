//
//  ContentView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 11.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherData = WeatherData()
    @State private var isNight = false
    @State private var selectedDay: WeatherDay
    @State private var showDetails = false
    
    init() {
        let initialDay = WeatherData().weeklyForecast[0]
        _selectedDay = State(initialValue: initialDay)
    }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            
            ScrollView {
                VStack(spacing: 20) {
                    HeaderContentView(cityname: "Santa Cruz, CA")
                    
                    MainContentView(day: selectedDay, isNight: isNight)
                        .onTapGesture {
                            withAnimation {
                                showDetails.toggle()
                            }
                        }
                    
                    if showDetails {
                        WeatherDetailsView(day: selectedDay)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    WeeklyForecastView(weeklyForecast: weatherData.weeklyForecast, selectedDay: $selectedDay)
                    
                    Spacer()
                    
                    WeatherButtonView(
                        cityname: "Night Mode",
                        bcolor: .mint,
                        textcolor: .white,
                        action: { isNight.toggle() }
                    )
                }
                .padding()
            }
        }
    }
}



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

struct DetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white.opacity(0.7))
            Spacer()
            Text(value)
                .foregroundColor(.white)
        }
    }
}



struct WeatherDayView: View {
    var day: WeatherDay
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Text(day.dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isSelected ? .yellow : .white)
            
            Image(systemName: day.imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            if let temperature = day.temperature {
                Text("\(temperature)°")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? .yellow : .white)
            }
        }
        .padding()
        .background(isSelected ? Color.white.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
}

// ... (keep HeaderView, BackgroundView, and WeatherButtonView unchanged)

#Preview {
    ContentView()
}


