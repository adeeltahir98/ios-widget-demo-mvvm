//
//  WeatherWidgetLargeView.swift
//  Weather
//
//  Created by Adeel Tahir on 17/12/2022.
//

import SwiftUI

struct WeatherWidgetLargeView: View {
    var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(viewModel.weatherIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 30, alignment: .leading)
                Text(viewModel.temperature).foregroundColor(.white)
                    .font(Font.system(size: 30, weight: .bold, design: .rounded))
                    .shadow(color: .black, radius: 3, x: 0.5, y: 0.5)
                Spacer()
                VStack {
                    Text(viewModel.current.WeatherText)
                        .foregroundColor(.white)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                    Text(viewModel.location).foregroundColor(.white)
                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                        .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                }.padding(.trailing, 10)
            }.padding()
            ForecastPanelView(forecast: viewModel.forecastInfo(), height: 30)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Text("Updated: \(Date().timeOnly())")
                .foregroundColor(.gray)
                .font(Font.system(size: 10, weight: .regular, design: .rounded))
        }
    }
}

struct WeatherWidgetLargeView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidgetLargeView(viewModel: WeatherViewModel())
    }
}
