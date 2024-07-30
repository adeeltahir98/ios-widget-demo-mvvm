//
//  WindAndPressurePanelView.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import SwiftUI

struct WindAndPressurePanelView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let screenWidth = UIScreen.main.bounds.width
    
    var bladeAnimation: Animation? {
        guard let duration = viewModel.bladeDuration else {
            return nil
        }

        return Animation.linear(duration: duration).repeatForever(autoreverses: false)
    }
    
    @State private var rotateLargeFan = true
    @State private var rotateSmallFan = true
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                HStack(alignment: .bottom) {
                    ZStack {
                        Image("stand_l")
                        Image("blade_big")
                            .rotationEffect(.degrees(rotateLargeFan ? 360*4 : 0))
                            .offset(y: -35)
                            .animation(self.bladeAnimation)
                            .onAppear() {
                                self.rotateLargeFan.toggle()
                            }
                    }
                    .offset(x: -35, y: 29)
                    ZStack {
                        Image("stand_s")
                        Image("blade_small")
                            .rotationEffect(.degrees(rotateSmallFan ? 360*4 : 0))
                            .offset(y: -25)
                            .animation(self.bladeAnimation)
                            .onAppear() {
                                self.rotateSmallFan.toggle()
                            }
                    }
                    .offset(x: 30, y: 29)
                }
                VStack(alignment: .center, spacing: 4) {
                    Text("Wind").foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                        .frame(alignment: .center)
                    Text(viewModel.feelsLike).foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                    Divider()
                    Text("Barometer").foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                    Text(viewModel.pressure).foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                }.padding()
            }
        }
        .frame(width: (screenWidth/2) - 20, height: 140)
//        .background(Color.blue)
    }
}

struct WindAndPressurePanelView_Previews: PreviewProvider {
    static var previews: some View {
        WindAndPressurePanelView(viewModel: WeatherViewModel())
    }
}
