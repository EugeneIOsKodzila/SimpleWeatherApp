//
//  ViewController.swift
//  TestWorkSiberian2
//
//  Created by Наташа on 27.06.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var manager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "ready!"
        setLocationData()
    }
    
    func setLocationData() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        label.text = "\(first.coordinate.longitude) | \(first.coordinate.latitude)"
    }
}

