//
//  WeatherWidgetSmallView.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import SwiftUI

struct WeatherWidgetSmallView: View {
    var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text(viewModel.location).foregroundColor(.white)
                    .font(Font.system(size: 15, weight: .regular, design: .rounded))
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                Text(viewModel.temperature).foregroundColor(.white)
                    .font(Font.system(size: 30, weight: .bold, design: .rounded))
                    .shadow(color: .black, radius: 3, x: 0.5, y: 0.5)
                Image(viewModel.weatherIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 30, alignment: .leading)
                Text(viewModel.current.WeatherText)
                    .foregroundColor(.white)
                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                Text("Updated: \(Date().timeOnly())")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 10, weight: .regular, design: .rounded))
            }
        }.frame(alignment: .leading)
        .onAppear {
                viewModel.fetchWeather()
            }
    }
}

struct WeatherWidgetSmallView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidgetSmallView(viewModel: WeatherViewModel())
    }
}
