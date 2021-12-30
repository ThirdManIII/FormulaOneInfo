//
//  ConstructorApiClient.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 06.12.2021.
//

import Foundation

protocol ConstructorsApiClient {
    func getConstructors(completion: @escaping (Result<[Constructor], Error>) -> Void)
    func getDriversForConstructor(constructorName: String, completion: @escaping (Result<[Driver], Error>) -> Void)
}

class ConstructorsApiClientImpl: ConstructorsApiClient {
    
    func getConstructors(completion: @escaping (Result<[Constructor], Error>) -> Void) {
        let session = URLSession.shared
        
        guard let urlSite = URL(string: "https://ergast.com/api/f1/2021/constructors.json") else {
            return
        }
        
        let urlRequest = URLRequest(url: urlSite)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ConstructorMRDataDTO.self, from: data)
                completion(.success(response.mrData.constructorTable.constructors))
            } catch(let error) {
                completion(.failure(error))
                print(error)
            }

        })
        
        dataTask.resume()
    }
    
    func getDriversForConstructor(constructorName: String, completion: @escaping (Result<[Driver], Error>) -> Void) {
        let session = URLSession.shared
        
        let domain = "https://ergast.com/api/f1/2021/constructors/"
        let url = domain + constructorName + "/drivers.json"
        
        guard let urlSite = URL(string: url) else {
            return
        }
        
        let urlRequest = URLRequest(url: urlSite)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(DriverMRDataDTO.self, from: data)
                completion(.success(response.mrData.driverTable.drivers))
            } catch(let error) {
                completion(.failure(error))
                print(error)
            }
        })
        
        dataTask.resume()
    }
    
}


