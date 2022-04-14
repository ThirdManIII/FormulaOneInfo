//
//  ApiClient.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 30.11.2021.
//

import Foundation

// Создание протокола действий приложения при получении данных из сети
protocol DriversApiClientProtocol {
    func getDrivers(completion: @escaping (Result<DriverMRDataDTO, Error>) -> Void)
    func getDriversForConstructor(
        constructorName: String,
        completion: @escaping (Result<DriverMRDataDTO, Error>) -> Void
    )
}

// Создание класса, выполняющего данный протокол
class DriversApiClient: DriversApiClientProtocol {
    let networkService = NetworkServiceImpl()
    func getDrivers(completion: @escaping (Result<DriverMRDataDTO, Error>) -> Void) {
        let url = "https://ergast.com/api/f1/2021/drivers.json"
        networkService.dataReceiving(url: url, decodeStruct: DriverMRDataDTO.self, completion: completion)
    }
    func getDriversForConstructor(
        constructorName: String,
        completion: @escaping (Result<DriverMRDataDTO, Error>) -> Void
    ) {
        let domain = "https://ergast.com/api/f1/2021/constructors/"
        let url = domain + constructorName + "/drivers.json"
        networkService.dataReceiving(url: url, decodeStruct: DriverMRDataDTO.self, completion: completion)
    }
}
