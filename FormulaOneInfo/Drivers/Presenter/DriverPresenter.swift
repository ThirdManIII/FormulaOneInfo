//
//  DriverPresenter.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 13.01.2022.
//

import Foundation

class DriverPresenter: OutputProtocol {
    weak var viewController: DriverViewController?
    var apiClient: DriversApiClientProtocol
    
    required init(viewController: DriverViewController, apiClient: DriversApiClientProtocol) {
        self.apiClient = apiClient
        self.viewController = viewController
    }
    
    var drivers: [Driver] = []
    
    func viewDidLoad() {
        showView()
    }
    
    func reloadButtonDidTapped() {
        showView()
    }
    
    private func loadData() {
        apiClient.getDrivers(completion: { [self] result in
            
            // Выводим выполнение кода в главный поток
            DispatchQueue.main.async {
                switch result {
                case .success(let driverData):
                    drivers = driverData.mrData.driverTable.drivers
                    
                    dataDidReceive(data: drivers)
                case .failure:
                    drivers = []
                    
                    dataDidNotReceive()
                }
            }
        })
    }
    
    private func dataDidReceive(data: [Driver]) {
        viewController?.loadData(data: data)
        
        viewController?.stopActivityIndicator()
    }
    
    private func dataDidNotReceive() {
        viewController?.stopActivityIndicator()
        
        viewController?.showErrorMessage()
    }
    
    private func showView() {
        viewController?.loadViewElements()
        loadData()
    }
}
