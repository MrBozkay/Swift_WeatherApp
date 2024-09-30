//
//  ContentView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 11.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherService = WeatherService()
    @State private var cityName = "Santa Cruz, CA"
    @State private var showDetails = false
    @State private var selectedDay: WeatherDay?
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: selectedDay?.isNight ?? false)
            
             ScrollView {
                VStack(spacing: 10) {
                    HeaderContentView(cityname: cityName)
                    
                    if let displayWeather = selectedDay ?? weatherService.currentWeather {
                        MainContentView(day: displayWeather)
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
                    
                    Spacer()
                    
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
                }
                .padding()
            }
        }
        .onAppear {
            weatherService.fetchWeather(for: cityName)
        }
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

#Preview {
    ContentView()
}