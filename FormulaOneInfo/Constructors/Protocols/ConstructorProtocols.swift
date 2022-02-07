//
//  ConstructorProtocols.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 19.01.2022.
//

import Foundation

protocol ConstructorInputProtocol {
    func loadViewElements()
    func loadData(data: [Constructor])
    func stopActivityIndicator()
    func showErrorMessage()
}
