//
//  MainContentView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI

struct MainContentView: View {
    
    var imgname: String
    var tempeture: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imgname)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(tempeture)°")
                .font(.system(size: 70, weight: .bold))
                .foregroundColor(.white)
            
        }
        .padding(.bottom, 45)
    }
}


