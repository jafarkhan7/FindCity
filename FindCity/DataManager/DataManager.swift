//
//  DataManager.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import Foundation

struct CitiesFileService: FileLoadService {
    var filePath: String {
        return DataConstants.sourceFile
    }

    var fileType: String {
        return DataConstants.sourceFileType
    }
}

protocol CitiesFileServiceAPI {
    func getCities(service: FileLoadService, completion: @escaping (_ result: DataResponse<[City]>) -> ())
}


import Foundation

protocol FileLoadService {
    var filePath: String { get }
    var fileType: String { get }
}


struct DataConstants {
    static let sourceFile = "cities"
    static let sourceFileType = "json"
}

enum DataResponse<T> {
    case success(T)
    case failure(Error)
}

enum FetchingDataState {
    case loading
    case finishedLoading
    case error(Error?)
}



class DataClient: CitiesFileServiceAPI {

    /**
    //     Call this method to perfom a web service of type `FileLoadService`
    //     - Parameter type: is generic type should be a model that confirm to `Codable` protocol
    //     - Parameter completion: result of type `DataResponse`.
    // */
    private func load<T>(type: T.Type, service: FileLoadService, completion: @escaping (DataResponse<T>) -> ()) where T: Decodable {
        onGlobal(qos: .userInitiated) {
            let fileUrl = loadFileFromNib(name: service.filePath, type: service.fileType)
            do {
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }

    //MARK:- Services
    func getCities(service: FileLoadService, completion: @escaping (DataResponse<[City]>) -> ()) {
        self.load(type: [City].self, service: service, completion: completion)
    }
}
