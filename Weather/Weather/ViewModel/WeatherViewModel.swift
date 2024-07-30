//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import UIKit
import SwiftUI
import Combine

public struct ForecastInfo {
    public let dow: String
    public let icon: String
    public let min: String
    public let max: String
}

class WeatherViewModel: ObservableObject {

    @Published var current: CurrentData
    
    public var forecast: ForecastData
    
    let location = "Mountain View, CA"
    private var disposables = Set<AnyCancellable>()
    
    init() {
        self.current = CurrentData(WeatherIcon: 7, WeatherText: "Partly Cloudy", Temperature: ImperialInfo(Imperial: AccuValue(Value: 55, Unit: "F")), RelativeHumidity: 22, ApparentTemperature: ImperialInfo(Imperial: AccuValue(Value: 64.0, Unit: "F")), Visibility: ImperialInfo(Imperial: AccuValue(Value: 10, Unit: "mi")), UVIndex: 4, Wind: WindInfo(Direction: DirectionDetail(Degrees: 268, Localized: "NW"), Speed: ImperialInfo(Imperial: AccuValue(Value: 6, Unit: "mph"))), Pressure: ImperialInfo(Imperial: AccuValue(Value: 29.81, Unit: "inHg")))
        
        self.forecast = ForecastData(DailyForecasts: [DailyData(Date: "", EpochDate: 789798, Temperature: ForecastTemperatureInfo(Minimum: AccuValue(Value: 50, Unit: "F"), Maximum: AccuValue(Value: 88, Unit: "F")), Day: ConditionsInfo(Icon: 6, IconPhrase: "")), DailyData(Date: "", EpochDate: 3423423, Temperature: ForecastTemperatureInfo(Minimum: AccuValue(Value: 51, Unit: "F"), Maximum: AccuValue(Value: 87, Unit: "F")), Day: ConditionsInfo(Icon: 6, IconPhrase: "")), DailyData(Date: "", EpochDate: 23423, Temperature: ForecastTemperatureInfo(Minimum: AccuValue(Value: 52, Unit: "F"), Maximum: AccuValue(Value: 86, Unit: "F")), Day: ConditionsInfo(Icon: 6, IconPhrase: "")), DailyData(Date: "", EpochDate: 234342, Temperature: ForecastTemperatureInfo(Minimum: AccuValue(Value: 53, Unit: "F"), Maximum: AccuValue(Value: 85, Unit: "F")), Day: ConditionsInfo(Icon: 6, IconPhrase: "")), DailyData(Date: "", EpochDate: 23332284, Temperature: ForecastTemperatureInfo(Minimum: AccuValue(Value: 54, Unit: "F"), Maximum: AccuValue(Value: 84, Unit: "F")), Day: ConditionsInfo(Icon: 6, IconPhrase: ""))])
    }
    
    fileprivate func doubleToRoundedString(dbl: Double?) -> String {
        guard let dbl = dbl else {
            return ""
        }

        guard dbl != 0.0 else {
            return "0"
        }

        return "\(Int(dbl.rounded()))"
    }
    
    fileprivate func pressureInInchesString(inches: Double) -> String {

        return String(format: "%.1f", inches) + " in."
    }
    
    //MARK: -  Current Weather View
    private func getWeatherTemperature(temperature: ImperialInfo) -> String {
        return "\(Int(temperature.Imperial.Value))°\(temperature.Imperial.Unit)"
    }
    
    private func getWeatherIconName(icon: Int) -> String {
        var iconString = ""
        if icon < 10 {
            iconString += "0\(icon)"
        } else {
            iconString += "\(icon)"
        }
        iconString += "-s"

        return iconString
    }
    
    public var temperature: String {
        return doubleToRoundedString(dbl: self.current.Temperature.Imperial.Value) + "°"
    }
    
    public var weatherIconName: String {
        return getWeatherIconName(icon: self.current.WeatherIcon)
    }
    
    //MARK: -  Details panel
    public var feelsLike: String {
        return doubleToRoundedString(dbl: self.current.ApparentTemperature.Imperial.Value) + "°"
    }

    public var uvIndexColor: Color {
        return self.current.UVIndex != nil ? UVIndex(value: self.current.UVIndex!).color : .blue
     }

    public var humidity: String {
        return self.current.RelativeHumidity != nil ? "\(self.current.RelativeHumidity!)" + "%" : "n/a"
    }

    public var visibility: String {
        return doubleToRoundedString(dbl: self.current.Visibility.Imperial.Value) + " mi"
    }
    
    fileprivate func dowFrom(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let formatter = DateFormatter()

        formatter.dateFormat = "EEEE"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = NSLocale.current

        let dow = formatter.string(from: date)
        return dow
    }
    
    //MARK: -  Wind and Pressure panel
    var windSpeedString: String {
        if (self.current.Wind.Speed?.Imperial.Value == nil || (self.current.Wind.Speed?.Imperial.Value)! < 0.5) {
            return "0"
        }
        return doubleToRoundedString(dbl: self.current.Wind.Speed?.Imperial.Value)
    }

    var windSpeed: Double? {
        return self.current.Wind.Speed?.Imperial.Value
    }

    var bladeDuration: Double? {
        var speed = 100.0       // this is actually rotation duration - less is faster (well, if > 0)
        guard let windSpeed = self.windSpeed else {
            return nil
        }

        if windSpeed > 11 {
            speed = 4
        } else if windSpeed > 7 {
            speed = 8
        } else if windSpeed > 4 {
            speed = 12
        } else if windSpeed > 1.2 {
            speed = 16
        }

        return speed
    }

    var windDirection: String {
        return self.current.Wind.Direction.Localized
    }

    var windSpeedInfo: String {
        let info = self.windSpeedString + " mph " + self.windDirection
        return info
    }

    var pressure: String {
        return pressureInInchesString(inches: self.current.Pressure.Imperial.Value)
    }
    
    //MARK: -  Forecast panel
    public func forecastInfo() -> [ForecastInfo] {
        var forecast = [ForecastInfo]()

        guard self.forecast.DailyForecasts.count > 1 else {
            return forecast
        }

        for index in 0...4 {
            let dailyInfo = self.forecast.DailyForecasts[index]

            let dowString = dowFrom(date: dailyInfo.EpochDate)
            let icon = getWeatherIconName(icon: dailyInfo.Day.Icon)
            let min = doubleToRoundedString(dbl: dailyInfo.Temperature.Minimum.Value) + "°"
            let max = doubleToRoundedString(dbl: dailyInfo.Temperature.Maximum.Value) + "°"
            forecast.append(ForecastInfo(dow: dowString, icon: icon, min: min, max: max))
            }

        return forecast
    }
}

extension WeatherViewModel {
    
    func fetchWeather() {
        let currentWeatherPublisher = NetworkManager<[CurrentData]>.fetchRequest(apiUrl: APIs.weather)
        let forecastWeatherPublisher = NetworkManager<ForecastData>.fetchRequest(apiUrl: APIs.forecastWeather)
        
        let _ = Publishers.Zip(currentWeatherPublisher, forecastWeatherPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let theError):
                    self.handleDownloadError(error: theError)
                }
            }, receiveValue: { (current, forecast) in
                DispatchQueue.main.async {
                    if current.count > 0 {
                        self.current = current.first!
                    }
                    self.forecast = forecast
                }
            })
            .store(in: &disposables)
    }
    
    func fetchCurrentWeather() {
        let currentWeatherPublisher = NetworkManager<[CurrentData]>.fetchRequest(apiUrl: APIs.weather)
    
        let _ = currentWeatherPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let theError):
                    self.handleDownloadError(error: theError)
                }
            }, receiveValue: { current in
                if current.count > 0 {
                    self.current = current.first!
                }

            })
            .store(in: &disposables)
    }
    
    func fetchWeather(completion: ((WeatherViewModel) -> Void)? = nil) {
        let currentWeatherPublisher = NetworkManager<[CurrentData]>.fetchRequest(apiUrl: APIs.weather)
        let forecastWeatherPublisher = NetworkManager<ForecastData>.fetchRequest(apiUrl: APIs.forecastWeather)
        
        let _ = Publishers.Zip(currentWeatherPublisher, forecastWeatherPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let theError):
                    self.handleDownloadError(error: theError)
                }
            }, receiveValue: { (current, forecast) in
                DispatchQueue.main.async {
                    if current.count > 0 {
                        self.current = current.first!
                    }
                    self.forecast = forecast
                    completion?(self)
                }
            })
            .store(in: &disposables)
    }
    
    private func handleDownloadError(error: NetworkError) {
        switch error {
        case NetworkError.invalidHTTPResponse:
            //print(error.errorDescription)
            break
        case NetworkError.invalidServerResponse:
            //print(error.errorDescription)
            break
        case NetworkError.jsonParsingError:
            //print(error.errorDescription)
            break
        default:
            //print(error.errorDescription)
            break
        }
    }
}
