//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by nigelli on 2023/4/8.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(type(of: self)) loaded its view.")
    }

    override func loadView() {
        mapView = MKMapView()
        view = mapView

        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybird", "Satellite"])
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
}
