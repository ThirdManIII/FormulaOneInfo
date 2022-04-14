//
//  DriverProtocols.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 19.01.2022.
//

import Foundation

protocol DriverInputProtocol: AnyObject {
    func loadViewElements()
    func loadData(data: [Driver])
    func stopActivityIndicator()
    func showErrorMessage()
}

protocol OutputProtocol {
    func viewDidLoad()
    func reloadButtonDidTapped()
}
