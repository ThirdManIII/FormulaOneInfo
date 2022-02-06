//
//  DriverDetailsPresenter.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 19.01.2022.
//

import Foundation

class DriverDetailsPresenter: OutputProtocol {
    private weak var viewController: DriverDetailsInputProtocol?
    
    init(viewController: DriverDetailsInputProtocol) {
        self.viewController = viewController
    }
    
    var driver: Driver?
    
    func viewDidLoad() {
        var vollerName: String {
            driver!.vorname + " " + driver!.name
        }
        
        viewController?.showInfo(data: driver, name: vollerName)
    }
}
