//
//  ConstructorDetailsProtocols.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 19.01.2022.
//

import Foundation

protocol ConstructorDetailsInputProtocol: AnyObject {
    func showInfo(constructorData: Constructor?)
    func loadData(driversData: [Driver])
    func showErrorMessage()
}
