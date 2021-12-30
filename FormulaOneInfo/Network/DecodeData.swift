//
//  WaysForData.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.12.2021.
//

import Foundation

protocol DecodeData {
    func decodeConstructors(completion: @escaping (Result<[Constructor], Error>) -> Void, data: Data)
    
    func decodeDrivers(completion: @escaping (Result<[Driver], Error>) -> Void, data: Data)
}

class DecodeDataImpl: DecodeData {
    func decodeConstructors(completion: @escaping (Result<[Constructor], Error>) -> Void, data: Data) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ConstructorMRDataDTO.self, from: data)
            completion(.success(response.mrData.constructorTable.constructors))
        } catch(let error) {
            completion(.failure(error))
            print(error)
        }
    }

    func decodeDrivers(completion: @escaping (Result<[Driver], Error>) -> Void, data: Data) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(DriverMRDataDTO.self, from: data)
            completion(.success(response.mrData.driverTable.drivers))
        } catch(let error) {
            completion(.failure(error))
            print(error)
        }
    }
}
