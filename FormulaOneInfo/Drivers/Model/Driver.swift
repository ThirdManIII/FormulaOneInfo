//
//  Driver.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.11.2021.
//

import Foundation

// Структура, в которую будут передаваться данные из интернета
struct DriverMRDataDTO: Decodable {
    let mrData: DriverTableDTO
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct DriverTableDTO: Decodable {
    let driverTable: DriversDTO
    enum CodingKeys: String, CodingKey {
        case driverTable = "DriverTable"
    }
}

struct DriversDTO: Decodable {
    let drivers: [Driver]
    enum CodingKeys: String, CodingKey {
        case drivers = "Drivers"
    }
}

struct Driver: Decodable, Equatable {
    let vorname: String
    let name: String
    let nummer: String?
    let geburtsdatum: String
    let nation: String
    let code: String?
    /* Перечисление, в котором устанавливается связь между переменными в структуре Driver
     и переменными в API */
    enum CodingKeys: String, CodingKey {
        case vorname = "givenName"
        case name = "familyName"
        case nummer = "permanentNumber"
        case geburtsdatum = "dateOfBirth"
        case nation = "nationality"
        case code = "code"
    }
}
