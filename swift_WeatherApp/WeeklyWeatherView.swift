//
//  WeeklyWeatherUIView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI


struct WeeklyWeatherView :View {
   
   var body: some View {
       
       @StateObject  var weatherData = WeatherData()
       @State  var isNight: Bool = false
       @State  var showWeeklyForecast: Bool = false
       ZStack {
           BackgroundView(isNight: isNight)
           
           VStack {
               HeaderContentView(cityname: "Santa Cruse LA")
           
               if showWeeklyForecast {
                   WeeklyWeatherIUView(isNight: $isNight)
               } else {
                   MainContentView(day: weatherData.weeklyForecast[0])
                   
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
                       text: "Change Day Time",
                       bcolor: .mint,
                       textcolor: .white,
                       isNight: $isNight)
                   
                   WeatherButtonView(
                       text: showWeeklyForecast ? "Current Weather" : "Weekly Forecast",
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
    WeeklyWeatherView()
}
