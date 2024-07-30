//
//  ForecastPanelView.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import SwiftUI

struct ForecastPanelView: View {
    let forecast: [ForecastInfo]
    var height: CGFloat
    
    var body: some View {
        Group {
        if (forecast.count > 0) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("5-DAY FORECAST")
                        .foregroundColor(.gray)
                        .font(Font.system(size: 14, weight: .regular, design: .rounded))
                        .padding(.leading, 10)
                    Divider()
                    Group {
                        ForEach((0...4), id: \.self) {
                            ForecastDayView(dailyWeather: self.forecast[$0])
                                .frame(height: height)
                            Divider()
                        }
                    }
                    .foregroundColor(.white)
                }
            } else {
                VStack {
                    Text("No data")
                }
                .padding(.bottom, 10)

            }
        }
        .padding()
//        .background(Color.blue)
    }

}

struct ForecastDayView: View {
    var dailyWeather: ForecastInfo

    var body: some View {
        HStack {
            Text(dailyWeather.dow)
                .frame(alignment: .leading)
                .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
            Spacer()
            Image(dailyWeather.icon)
            Image("HighTemp")
                .resizable()
                .frame(width: 13, height: 17)
                .aspectRatio(contentMode: .fit)
                
            Text(dailyWeather.max).shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
            Image("LowTemp")
                .resizable()
                .frame(width: 13, height: 17)
                .aspectRatio(contentMode: .fit)
            Text(dailyWeather.min).shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
        }.padding(.leading, 10)
        .padding(.trailing, 10)
    }
}

struct ForecastPanelView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastPanelView(forecast: WeatherViewModel().forecastInfo(), height: 30)
    }
}
