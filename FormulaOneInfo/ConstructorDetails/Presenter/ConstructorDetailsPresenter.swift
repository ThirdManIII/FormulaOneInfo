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
    var constructorName: String {
        constructor?.constructorId ?? ""
    }
    
    func viewDidLoad() {
        viewController?.loadViewElements()
        viewController?.showInfo(constructorData: constructor)
        
        loadData()
    }
    
    func reloadButtonDidTapped() {
        viewController?.loadViewElements()
        
        loadData()
    }
    
    private func loadData() {
        apiClient.getDriversForConstructor(constructorName: constructorName, completion: { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let driversData):
                    drivers = driversData.mrData.driverTable.drivers
                    viewController?.loadData(driversData: drivers)
                    
                    viewController?.stopActivityIndicator()
                case .failure:
                    drivers = []
                    
                    viewController?.showErrorMessage()
                    viewController?.stopActivityIndicator()
                }
            }
        })
    }
}
