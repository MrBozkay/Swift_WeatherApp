//
//  WeatherSubView_1.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI

struct WeatherSubView_1: View {
   
   let day : String
   let imageName : String
   let temperature : Int

   var body: some View {
        VStack {
            Text(day)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
            
            Image(systemName: imageName)
                .symbolRenderingMode(.palette)
                .resizable()
                .foregroundStyle(.white, .yellow, Color("lightblue"))
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
   }
}

#Preview {
    WeatherSubView_1(day: "WED", imageName: "cloud.sun.rain", temperature: 5)
}
