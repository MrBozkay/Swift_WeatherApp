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
           let initialDay = WeatherData().weatherDays[0]
           _selectedDay = State(initialValue: initialDay)
       }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            
            VStack {
                HeaderContentView(cityname: "Santa Cruz, CA")
            
                MainContentView(imgname: selectedDay.imageName, tempeture: selectedDay.temperature)
                
                HStack(spacing: 15) {
                    ForEach(weatherData.weatherDays, id: \.dayOfWeek) { day in
                        WeatherSubView(day: day)
                            .onTapGesture {
                                selectedDay = day
                            }
                    }
                }
        
                Spacer()
                
                WeatherButtonView(
                    cityname: "Change Day Time",
                    bcolor: .mint,
                    textcolor: .white,
                    isNight: $isNight
                )
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}


