//
//  CityViewController.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import UIKit
import Combine

class CityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var subscriptions = Set<AnyCancellable>()
    @IBOutlet weak var labelResultCount: UILabel!

    private var citiesViewModel: CitiesViewModel?
    
    
    //MARK: - Binding the ViewModel
    func bindViewModel(viewModel: CitiesViewModel) {
        citiesViewModel = viewModel
        self.title = citiesViewModel?.title
        citiesViewModel?.$cities.sink { [weak self] cities in
            onMain { [weak self] in
                self?.tableView.reloadData()
                self?.labelResultCount.text = "\(cities?.count ?? 0) cities found"
            }
        }.store(in: &subscriptions)
        
        citiesViewModel?.$state.sink { [weak self] loading in
            onMain { [weak self] in
                switch loading {
                case .loading:
                    self?.show(loading: true)
                case .finishedLoading:
                    self?.show(loading: false)
                case .error(let error):
                    self?.show(loading: false)
                    //Showing the alert if there is any error occured
                    self?.showAlert(withTitle: "Error", withMessage: error?.localizedDescription ?? "")
                }
            }
        }.store(in: &subscriptions)

    }
    ///Updating the UI Based on the result
    private func show(loading: Bool) {
        onMain { [weak self] in
            self?.tableView.isHidden = loading
            self?.labelResultCount.isHidden = loading
            self?.progressView.isHidden = !loading
            self?.searchBar.isHidden = loading
            loading == true ? self?.progressView.startAnimating() : self?.progressView.stopAnimating()
        }
    }
    
}

extension CityViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier) as? CityCell, let cityViewModel = citiesViewModel?.cities?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configureView(viewModel: cityViewModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesViewModel?.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let cityViewModel = citiesViewModel?.cities?[indexPath.row] {
        let cityDetailVC = CityDetailViewController.getViewController()
            cityDetailVC.bindViewModel(viewModel: cityViewModel)
            self.navigationController?.pushViewController(cityDetailVC, animated: true)
        }
    }
    
}


//MARK:- UISearchBarDelegate
extension CityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handleSearchMode(.textDidChange(searchText: searchBar.text ?? ""))
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        handleSearchMode(.beginEditing(searchText: searchBar.text ?? ""))

        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        handleSearchMode(.cancel)
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    fileprivate func handleSearchMode(_ searchMode: CitiesViewModel.SearchMode) {
        citiesViewModel?.searchMode = searchMode
    }
}
