//
//  WeatherDayView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 1.10.2024.
//

import SwiftUI

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

//#Preview {
//    WeatherDayView()
//}
