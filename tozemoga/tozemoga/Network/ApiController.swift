//
//  ApiController.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-11.
//

import Foundation

protocol ApiControllerProtocol {
    func load<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

class ApiController: ApiControllerProtocol {
    private let baseUrl = "https://jsonplaceholder.typicode.com"
    private let session: URLSession
    var isLoading = false
    var isLoadingObserver: ((Bool) -> Void)? = nil
    
    init(session: URLSession = .shared) {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15 // set timeout
        self.session = URLSession(configuration: config)
    }
    
    func load<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        isLoading = true
        let url = URL(string: baseUrl + endpoint.path)!
        session.dataTask(with: url) {[weak self](data, _, error) in
            guard let self = self else { return }
            self.isLoading = false
            self.isLoadingObserver?(self.isLoading)
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data not found."])
                completion(.failure(error))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}
