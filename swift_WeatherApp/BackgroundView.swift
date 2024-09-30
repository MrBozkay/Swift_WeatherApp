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
        LinearGradient(gradient: Gradient(colors: isNight ? [Color.blue, Color.white] : [Color.black, Color.gray]), startPoint: .topLeading, endPoint: .bottom)
            .ignoresSafeArea()

/*         after ios 16+
 ContainerRelativeShape()
        .fill(isNight ? Color.black.gradient : Color.blue.gradient)
        .ignoresSafeArea() */
    }
}

