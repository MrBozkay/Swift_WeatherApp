//
//  WeatherSubView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI

struct WeatherSubView: View {
    var day: WeatherDay
    
    var body: some View {
        VStack {
            Text(day.dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
            
            Image(systemName: day.imageName)
                .symbolRenderingMode(.palette)
                .resizable()
                .foregroundStyle(.white, .yellow, Color("lightblue"))
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(day.temperature ?? 56)°")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

//let Weatherday: WeatherDay = WeatherDay(dayOfWeek: "MON", imageName: "cloud.sun.fill", temperature: 64)
//
//#Preview {
//    WeatherSubView(day: Weatherday)
//}
