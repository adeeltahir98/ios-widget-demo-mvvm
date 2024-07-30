//
//  WeatherModels.swift
//  Weather
//
//  Created by Adeel Tahir on 16/12/2022.
//

import UIKit
import SwiftUI

public struct ForecastData : Codable {
    let DailyForecasts : [DailyData]
}

struct DailyData : Codable {
    let Date: String
    let EpochDate: Int
    let Temperature: ForecastTemperatureInfo
    let Day: ConditionsInfo
}

struct ForecastTemperatureInfo : Codable {
    let Minimum: AccuValue
    let Maximum: AccuValue
}

struct ConditionsInfo : Codable {
    let Icon: Int
    let IconPhrase: String
}

struct CurrentData: Codable {
    let WeatherIcon: Int
    let WeatherText: String
    let Temperature: ImperialInfo
    let RelativeHumidity: Int?
    let ApparentTemperature: ImperialInfo
    let Visibility: ImperialInfo
    let UVIndex: Int?
    let Wind: WindInfo
    let Pressure: ImperialInfo
}

struct ImperialInfo : Codable {
    let Imperial: AccuValue
}

struct AccuValue : Codable {
    let Value: Double
    let Unit: String
}

struct WindSpeed : Codable {
    let Imperial: AccuValue
}

struct WindInfo : Codable {
    let Direction: DirectionDetail
    let Speed: ImperialInfo?
}

struct DirectionDetail : Codable {
    let Degrees: Int
    let Localized: String
}

enum UVIndex {
    case high
    case medium
    case mediumHigh
    case low

    init(value: Int) {
        switch value {
            case 0...2:
                self = .low
            case 3...5:
                self = .medium
            case 6...7:
                self = .mediumHigh
            default:
                self = .high
        }
    }

    var color: Color {
        switch self {
            case .high:
                return .red
            case .mediumHigh:
                return .orange
            case .medium:
                return .yellow
            case .low:
                return .green
        }
    }
}
