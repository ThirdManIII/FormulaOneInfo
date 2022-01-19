//
//  ConstructorApiClient.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 06.12.2021.
//

import Foundation

protocol ConstructorsApiClientProtocol {
    func getConstructors(completion: @escaping (Result<ConstructorMRDataDTO, Error>) -> Void)
}

class ConstructorsApiClient: ConstructorsApiClientProtocol {
    let networkService = NetworkServiceImpl()
    
    func getConstructors(completion: @escaping (Result<ConstructorMRDataDTO, Error>) -> Void) {
        let url = "https://ergast.com/api/f1/2021/constructors.json"
       
        networkService.dataReceiving(url: url, decodeStruct: ConstructorMRDataDTO.self, completion: completion)
    }
    

}


