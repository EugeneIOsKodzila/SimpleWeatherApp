//
//  CurrentWeather.swift
//  TestWorkSiberian2
//
//  Created by Наташа on 01.07.2022.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Int
    
    var model: WeatherModel {
        return WeatherModel(countryName: name,
                            temp: String(format: "%.f", main.temp),
                            conditionId: weather.first?.id ?? 0,
                            conditionDescription: weather.first?.description ?? "",
                            pressure: main.pressure,
                            dt:dt)
    }
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}

struct WeatherModel {
    let countryName: String
    let temp: String
    let conditionId: Int
    let conditionDescription: String
    let pressure: Int
    let dt: Int
    
    var conditionImage: String {
        switch conditionId {
        case 200...299:
            return "imThunderstorm"
        case 300...399:
            return "imDrizzle"
        case 500...599:
            return "imRain"
        case 600...699:
            return "imSnow"
        case 700...799:
            return "imAtmosphere"
        case 800:
            return "imClear"
        default:
            return "imClouds"
        }
    }
}
