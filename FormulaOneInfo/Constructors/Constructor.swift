//
//  Constructors.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.11.2021.
//

import Foundation

struct ConstructorMRDataDTO: Decodable {
    let mrData: ConstructorTableDTO
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct ConstructorTableDTO: Decodable {
    let constructorTable: ConstructorsDTO
    
    enum CodingKeys: String, CodingKey {
        case constructorTable = "ConstructorTable"
    }
}

struct ConstructorsDTO: Decodable {
    let constructors: [Constructor]
    
    enum CodingKeys: String, CodingKey {
        case constructors = "Constructors"
    }
}

struct Constructor: Decodable {
    let name: String
    let nation: String
    let constructorId: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case nation = "nationality"
        case constructorId = "constructorId"
    }
}
