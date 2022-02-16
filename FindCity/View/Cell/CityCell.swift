//
//  CityCell.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import UIKit

final class CityCell: UITableViewCell {
    
    ///Showing the detail based on the viewModel information
    func configureView(viewModel: CityViewModel) {
        self.textLabel?.text = viewModel.cityName()
        self.detailTextLabel?.text =  viewModel.cityCoordsDescription()
    }
}
