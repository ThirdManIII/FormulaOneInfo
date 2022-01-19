//
//  DriverProtocols.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 19.01.2022.
//

import Foundation

protocol DriverInputProtocol: AnyObject {
    func loadData(data: [Driver])
}

protocol OutputProtocol {
    func viewDidLoad()
}
