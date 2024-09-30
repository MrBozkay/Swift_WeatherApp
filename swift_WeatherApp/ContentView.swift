//
//  ContentView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 11.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherService = WeatherService()
    @State private var isNight = true
    @State private var cityName = "Santa Cruz, CA"
    @State private var showDetails = false
    @State private var selectedDay: WeatherDay?
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            
             ScrollView {
                VStack(spacing: 10) {
                    HeaderContentView(cityname: cityName)
                    
                    if let displayWeather = selectedDay ?? weatherService.currentWeather {
                        MainContentView(day: displayWeather, isNight: isNight)
                            .onTapGesture {
                                withAnimation {
                                    showDetails.toggle()
                                }
                            }
                        
                        if showDetails {
                            WeatherDetailsView(day: displayWeather)
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        WeeklyForecastView(weeklyForecast: weatherService.weeklyForecast, selectedDay: $selectedDay)
                    } else if let error = weatherService.error {
                        Text(error)
                            .foregroundColor(.red)
                    } else {
                        ProgressView()
                    }
                    
                    
                    
                    HStack {
                        TextField("Enter city name", text: $cityName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                        
                        Button(action: {
                            weatherService.fetchWeather(for: cityName)
                            selectedDay = nil // Reset selected day when searching for a new city
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 2)
                    }
                    .padding()
                    
                    WeatherButtonView(
                        text: "Night Mode",
                        bcolor: .mint,
                        textcolor: .white,
                        action: { isNight.toggle() }
                    )
                }
                .padding()
            }
        }
        .onAppear {
            weatherService.fetchWeather(for: cityName)
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


