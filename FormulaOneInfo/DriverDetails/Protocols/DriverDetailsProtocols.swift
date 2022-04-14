//
//  DriverDetailsProtocols.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 19.01.2022.
//

import Foundation

protocol DriverDetailsInputProtocol: AnyObject {
    func showInfo(data: Driver?, name: String)
}

protocol DetailsOutputProtocol: AnyObject {
    func viewDidLoad()
}
