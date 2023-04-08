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
    }
}
