//
//  WeatherButtonView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 12.09.2024.
//

import Foundation
import SwiftUI

// Update WeatherButtonView to accept an optional action
struct WeatherButtonView: View {
    var cityname: String
    var bcolor: Color
    var textcolor: Color
    var isNight: Binding<Bool>? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button {
            if let isNight = isNight {
                isNight.wrappedValue.toggle()
            }
            action?()
        } label: {
            Text(cityname)
                .frame(width: 280, height: 50)
                .background(bcolor)
                .foregroundColor(textcolor)
                .font(.system(size: 20, weight: .bold))
                .cornerRadius(10)
        }
    }
}
