//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by nigelli on 2023/4/8.
//

import MapKit
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var locateRegionWhenFirstComeIn: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(type(of: self)) loaded its view.")
        checkLocationAuthorizationStatus()
    }

    override func loadView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString
            = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl
            = UISegmentedControl(items: [standardString, hybridString, satelliteString])

        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        view.addSubview(segmentedControl)

        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true

        let tipsLabel = UILabel()
        tipsLabel.textColor = UIColor.systemBlue
        tipsLabel.text = "Points of Interest"
        tipsLabel.sizeToFit()
        tipsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tipsLabel)

        let topConstraintOfTipsLabel = tipsLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16.0)
        let leadingConstraintOfTipsLabel = tipsLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)

        topConstraintOfTipsLabel.isActive = true
        leadingConstraintOfTipsLabel.isActive = true

        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(updatePointOfInterests(_:)), for: .valueChanged)
        view.addSubview(switcher)

        let topConstraintOfSwitcher = switcher.centerYAnchor.constraint(equalTo: tipsLabel.centerYAnchor)
        let leadingConstraintOfSwitcher = switcher.leadingAnchor.constraint(equalTo: tipsLabel.trailingAnchor, constant: 10)
        topConstraintOfSwitcher.isActive = true
        leadingConstraintOfSwitcher.isActive = true

        locationManager.delegate = self
    }

    @objc func mapTypeChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

    @objc func updatePointOfInterests(_ switcher: UISwitch) {
        if !switcher.isOn {
            mapView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: .flat)
            return
        }

        let includingArr: [MKPointOfInterestCategory] = [.airport, .amusementPark, .aquarium]
        let pointOfInterestFilter = MKPointOfInterestFilter(including: includingArr)
        let hybridMapConfiguration = MKHybridMapConfiguration(elevationStyle: .flat)
        hybridMapConfiguration.pointOfInterestFilter = pointOfInterestFilter
        mapView.preferredConfiguration = hybridMapConfiguration
    }

    func checkLocationAuthorizationStatus() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locateRegionWhenFirstComeIn {
            let location = locations.first!
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let coordinateRegion = MKCoordinateRegion(center: center,
                                                      span:
                                                      MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            mapView.setRegion(coordinateRegion, animated: true)
            locateRegionWhenFirstComeIn = false
        }
    }
}
