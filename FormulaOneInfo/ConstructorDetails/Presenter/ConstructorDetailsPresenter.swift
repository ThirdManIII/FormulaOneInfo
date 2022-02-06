//
//  ConstructorDetailsPresenter.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 19.01.2022.
//

import Foundation

class ConstructorDetailsPresenter: OutputProtocol {
    private weak var viewController: ConstructorDetailsInputProtocol?
    private var apiClient: DriversApiClientProtocol
    
    required init(viewController: ConstructorDetailsInputProtocol, apiClient: DriversApiClientProtocol) {
        self.viewController = viewController
        self.apiClient = apiClient
    }
    
    var constructor: Constructor?
    var drivers: [Driver] = []
    
    
    
    func viewDidLoad() {
        viewController?.showInfo(constructorData: constructor)
        
        apiClient.getDriversForConstructor(constructorName: constructor!.constructorId, completion: { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let driversData):
                    self.drivers = driversData.mrData.driverTable.drivers
                    
                    viewController?.loadData(driversData: drivers)
                case .failure:
                    self.drivers = []
                    
                    viewController?.showErrorMessage()
                }
            }
        })
    }
}
