//
//  DriversDetailsViewController.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.11.2021.
//

import UIKit

class DriverDetailsViewController: UIViewController {
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var landLabel: UILabel!
    
    var output: OutputProtocol?
    
    var driver: Driver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
    }
    
}

extension DriverDetailsViewController: DriverDetailsInputProtocol {
    func showInfo(data: Driver?, name: String) {
        navigationItem.title = name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        numberLabel.text = data?.nummer
        dateLabel.text = data?.geburtsdatum
        landLabel.text = data?.nation
    }
    
    
}
