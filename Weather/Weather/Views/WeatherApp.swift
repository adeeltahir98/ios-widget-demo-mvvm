//
//  WeatherApp.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: WeatherViewModel())
        }
    }
}
