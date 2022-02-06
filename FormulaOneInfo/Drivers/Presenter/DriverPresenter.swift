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
    
    func tableViewDidLoad() {
        viewController?.loadData(data: drivers)
    }
    
    private func dataDidReceive(data: [Driver]) {
        viewController?.loadData(data: data)
        
        viewController?.driversList.reloadData()
        
        viewController?.activityIndicator.stopAnimating()
        viewController?.activityIndicator.isHidden = true
    }
    
    private func dataDidNotReceive() {
        viewController?.activityIndicator.stopAnimating()
        viewController?.activityIndicator.isHidden = true
        
        viewController?.errorLabel.isHidden = false
        viewController?.reloadButton.isHidden = false
    }
}
