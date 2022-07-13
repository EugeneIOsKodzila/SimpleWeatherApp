//
//  NetworkService.swift
//  TestWorkSiberian2
//
//  Created by Наташа on 29.06.2022.
//

import Foundation
import Alamofire

class WeatherManager {
    private let apiKey = "d7d3dba21f6b18dd74f44281398f4589"
    
    func featherWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let urlString = String("https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longitude.description)&units=metric&lang=ru&APPID=\(apiKey)")
        AF.request(urlString).responseDecodable(of: WeatherData.self, queue: .main, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let weatherData):
                let weatherModel = weatherData.model
                completion(.success(weatherModel))
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}

