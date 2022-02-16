//
//  CitiesViewModel.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import Combine
import Foundation

final class CitiesViewModel {
    @Published private(set) var cities : [CityViewModel]?
    fileprivate private(set) var allCities : [City]?
    @Published private(set) var state: FetchingDataState = .loading
    private(set) var searchQuery: String?
    private(set) var subscriptions = Set<AnyCancellable>()
    @Published var searchMode: SearchMode? = nil
    
    enum SearchMode: Equatable {
        case beginEditing(searchText: String)
        case textDidChange(searchText: String)
        case cancel
    }
    
    var title: String {
        return "Cities"
    }
    
    init() {
        fetchCity()
        bindSearchMode()
    }
}

fileprivate extension CitiesViewModel {
    
    func bindSearchMode() {
        
        $searchMode.sink { [weak self] searchMode in
            switch searchMode {
            case .beginEditing(let searchText):
                self?.searchDidBeginEditing(query: searchText)
            case .textDidChange(searchText: let searchText):
                self?.searchTextChanged(query: searchText)
            case .cancel:
                self?.resetSearch()
            case .none: break;
            }
        }.store(in: &subscriptions)

    }
    
    func searchTextChanged(query: String?) {
        searchQuery = query
        if query == nil || query?.isEmpty == true {
            resetSearch()
        } else {
            searchCity()
        }
    }
    
    func searchDidBeginEditing(query: String?) {
        searchQuery = query
        if query == nil || query?.isEmpty == true {
            resetSearch()
        }
    }
    
    func resetSearch() {
        searchQuery = nil
        onGlobal(qos: .userInitiated) {[weak self] in
            self?.cities = self?.allCities?.compactMap { CityViewModel(city: $0) }
        }
        
    }
    
    func fetchCity() {
        let data = DataClient()
        data.getCities(service: CitiesFileService()) { [weak self] cities in
            switch cities {
            case .success(let result):
                self?.allCities = result.sorted {$0.name < $1.name}
                self?.cities = self?.allCities?.compactMap { CityViewModel(city: $0) }
                self?.state = .finishedLoading
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
    
    func searchCity() {
        guard let query = searchQuery else { return }
        onGlobal(qos: .userInitiated) {[weak self] in
            self?.cities = self?.allCities?.filter({ $0.name.lowercased().hasPrefix(query.lowercased()) }).compactMap { CityViewModel(city: $0) }
        }
    }
}

