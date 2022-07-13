//
//  ViewController.swift
//  TestWorkSiberian2
//
//  Created by Наташа on 27.06.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var manager: CLLocationManager = CLLocationManager()
    private let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationData()
    }
    
    func setLocationData() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func formatDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from: Date.init())
        return dateString
    }
    
    private func updateView(withModel model: WeatherModel) {
        cityLabel.text = model.countryName
        temperatureLabel.text = "\(model.temp)°C"
        pressureLabel.text = "давление: \(model.pressure)"
        iconImage.image = UIImage(named: model.conditionImage)
        dateTimeLabel.text = formatDateTime()
    }
}
//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            weatherManager.featherWeather(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude) { [weak self] result in
                switch result {
                case .success(let weatherModel):
                    guard let self = self else { return }
                    self.updateView(withModel: weatherModel)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

