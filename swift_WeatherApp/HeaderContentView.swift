//
//  HeaderContentView.swift
//  swift_WeatherApp
//
//  Created by mustafa bozkaya on 30.09.2024.
//

import SwiftUI

struct HeaderContentView: View {
    let cityname: String
    var body: some View {
        Text(cityname)
            .font(.system(size: 32, weight: .medium))
            .foregroundStyle(Color.white)
            .padding()
    }
}

#Preview {
    HeaderContentView(cityname: "istanbul")
}
