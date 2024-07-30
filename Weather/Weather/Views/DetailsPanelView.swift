//
//  DetailsPanelView.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import SwiftUI

struct DetailsPanelView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            HStack {
                Text("Feels like").foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in -190 } )
                Spacer()
                Text(viewModel.feelsLike).foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
            }
            Divider()
            HStack {
                Text("Humidity").foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                Spacer()
                Text(viewModel.humidity).foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
            }
            Divider()
            HStack {
                Text("Visibility").foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                Spacer()
                Text(viewModel.visibility).foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
            }
            Divider()
            HStack {
                Text("UV Index").foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                Spacer()
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .frame(width: 30, height: 10)
                    .foregroundColor(viewModel.uvIndexColor)
            }.padding(.bottom, 0)
        }.padding()
        .frame(width: (screenWidth/2) - 20, height: 140)
    }
}

struct DetailsPanelView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsPanelView(viewModel: WeatherViewModel())
    }
}
