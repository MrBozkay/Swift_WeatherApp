//
//  BackgroundView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI
import Foundation

struct BackgroundView: View {
    //    let startcolor : Color
    //    let endcolor : Color
    let isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [
            isNight ? .black : .blue,
            isNight ? .gray : Color("lightblue")
        ]), startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()

/*         after ios 16+
 ContainerRelativeShape()
        .fill(isNight ? Color.black.gradient : Color.blue.gradient)
        .ignoresSafeArea() */
    }
}

