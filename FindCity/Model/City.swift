//
//  City.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let coordinates: CityCoordinate

    enum CodingKeys: String, CodingKey {
        case name, country
        case id = "_id"
        case coordinates = "coord"
    }
}

struct CityCoordinate: Codable {
    let longitude: Double
    let latitude: Double

    enum CodingKeys: String, CodingKey {
         case longitude = "lon"
         case latitude = "lat"
     }
}
