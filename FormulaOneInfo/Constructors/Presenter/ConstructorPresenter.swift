//
//  ConstructorPresenter.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 19.01.2022.
//

import Foundation

class ConstructorPresenter: OutputProtocol {
    private weak var viewController: ConstructorViewController?
    private var apiClient: ConstructorsApiClientProtocol
    
    var constructors: [Constructor] = []
    
    required init(viewController: ConstructorViewController, apiClient: ConstructorsApiClientProtocol) {
        self.viewController = viewController
        self.apiClient = apiClient
    }
    
    func viewDidLoad() {
        apiClient.getConstructors(completion: { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let constructorData):
                    constructors = constructorData.mrData.constructorTable.constructors
                    
                    dataDidReceive(data: constructors)
                case .failure:
                    constructors = []
                    
                    dataDidNotReceive()
                }
            }
        })
    }
    
    private func dataDidReceive(data: [Constructor]) {
        viewController?.loadData(data: data)
        viewController?.constructorsList.reloadData()
        
        viewController?.stopActivityIndicator()
    }
    
    private func dataDidNotReceive() {
        viewController?.constructorsList.reloadData()
        viewController?.stopActivityIndicator()
        
        viewController?.errorLabel.isHidden = false
        viewController?.reloadButton.isHidden = false
    }
}
