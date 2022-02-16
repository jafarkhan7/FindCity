//
//  CityViewModel.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import MapKit

struct CityViewModel {
    private var city: City

    init(city: City) {
        self.city = city
    }

    func cityName() -> String {
        return "\(city.name), \(city.country)"
    }

    func cityCoordsDescription() -> String {
        return "\(city.coordinates.latitude), \(city.coordinates.longitude)"
    }

    func location() -> CLLocation {
        return CLLocation(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude)
    }
}
