//
//  MKMapViewExtension.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import MapKit

extension MKMapView {
    func moveToLocation(_ location: CLLocation, showAnnotation: Bool = true, regionRadius: CLLocationDistance = 7000) {
        
        if showAnnotation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            addAnnotation(annotation)
        }
        
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: CLLocationDistance(exactly: regionRadius)!,
                                        longitudinalMeters: CLLocationDistance(exactly: regionRadius)!)
        setRegion(regionThatFits(region), animated: true)
    }
}
