//
//  ContentView.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(uiColor: UIColor.init(hex: "#1F3568")!), Color(uiColor: UIColor(hex: "#495E92")!), Color(uiColor: UIColor(hex: "#B1886E")!)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ScrollView {
                Spacer(minLength: 30)
                CurrentWeatherView(viewModel: viewModel)
                Spacer(minLength: 30)
                HStack {
                    DetailsPanelView(viewModel: viewModel)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(15)
                    WindAndPressurePanelView(viewModel: viewModel)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(15)
                }
                ForecastPanelView(forecast: viewModel.forecastInfo(), height: 40)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                    .padding()
                
            }.frame(alignment: .leading)
        }
        .onAppear {
//            viewModel.fetchWeather()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
//            .background(Color.blue)
    }
}
