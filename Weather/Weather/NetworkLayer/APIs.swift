//
//  APIs.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import Foundation

struct AccuWeatherAPI {
    static let locationCode = "337169"         // Mountain View, CA
    static let accuWeatherapikey = "vE6LAdGT9fdl8KOnMODoKneZuH38PPng"  // <your AccuWeather api key>
}

struct APIs {
    static var weather = "https://dataservice.accuweather.com/currentconditions/v1/\(AccuWeatherAPI.locationCode)?apikey=\(AccuWeatherAPI.accuWeatherapikey)&details=true"
    static var forecastWeather = "https://dataservice.accuweather.com/forecasts/v1/daily/5day/\(AccuWeatherAPI.locationCode)?apikey=\(AccuWeatherAPI.accuWeatherapikey)&details=true"
    static var hourlyForecastWeather = "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(AccuWeatherAPI.locationCode)?apikey=\(AccuWeatherAPI.accuWeatherapikey)&details=false"
}
