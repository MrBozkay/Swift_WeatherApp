//
//  ContentViewWeeklyBtn.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//



import SwiftUI

struct ContentViewWeeklyBtn: View {
    
    @State private var isNight: Bool = false
    @State private var showWeeklyForecast: Bool = false

    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            
            VStack {
                HeaderContentView(cityname: "Santa Cruse LA")
            
                if showWeeklyForecast {
                    WeeklyForecastView(isNight: $isNight)
                } else {
                    MainContentView(imgname: isNight ? "moon.stars.fill" : "cloud.sun.fill", tempeture: 64)
                    
                    HStack(spacing: 15) {
                    WeatherSubView_1(day: "WED", imageName: "cloud.sun.rain", temperature: 58)
                    WeatherSubView_1(day: "WED", imageName: "cloud.sun.rain", temperature: 58)
                    WeatherSubView_1(day: "TUE", imageName: "cloud.sun.fill", temperature: 64)
                    WeatherSubView_1(day: "THU", imageName: "wind.snow", temperature: 54)
                    WeatherSubView_1(day: "FRI", imageName: "cloud.sun.rain.fill", temperature: 65)
                    WeatherSubView_1(day: "SAT", imageName: "cloud.sun.bolt.fill", temperature: 64)
                    WeatherSubView_1(day: "SUN", imageName: "snow", temperature: 48)
                                       }
                }
        
                Spacer()
                
                VStack(spacing: 20) {
                    WeatherButtonView(
                        cityname: "Change Day Time",
                        bcolor: .mint,
                        textcolor: .white,
                        isNight: $isNight)
                    
                    WeatherButtonView(
                        cityname: showWeeklyForecast ? "Current Weather" : "Weekly Forecast",
                        bcolor: .orange,
                        textcolor: .white,
                        action: { showWeeklyForecast.toggle() })
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentViewWeeklyBtn()
}


