//
//  DriversForConstructor.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 06.12.2021.
//

import Foundation

protocol NetworkService {
    func dataReceiving(decode: @escaping ((Result<Data, Error>) -> Void, Data) -> Void, url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkServiceImpl: NetworkService {
    
    func dataReceiving(decode: @escaping ((Result<Data, Error>) -> Void, Data) -> Void, url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        
        guard let urlSite = URL(string: url) else {
            return
        }
        
        
        let urlRequest = URLRequest(url: urlSite)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            guard data != nil else {
                completion(.failure(ApiError.noData))
                return
            }
            
            decode(completion, data!)

        })
        
        dataTask.resume()
    }
    
}
