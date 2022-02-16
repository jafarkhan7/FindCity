//
//  CityDetailViewController.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import UIKit
import MapKit

class CityDetailViewController: UIViewController {
    
    private var cityViewModel : CityViewModel?
    
    @IBOutlet weak var mapView: MKMapView!
    
    func bindViewModel(viewModel: CityViewModel) {
        self.cityViewModel = viewModel
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let city = cityViewModel else {return}
        self.title = city.cityName()
        showAnnotation(city: city)
    }
    
    
    func showAnnotation(city: CityViewModel) {
        mapView.moveToLocation(city.location())
    }
}
