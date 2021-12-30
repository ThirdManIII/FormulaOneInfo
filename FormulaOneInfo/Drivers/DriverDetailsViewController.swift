//
//  DriversDetailsViewController.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.11.2021.
//

import UIKit

class DriverDetailsViewController: UIViewController {
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var landLabel: UILabel!
    
    var driver: Driver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var vollerName: String {
            driver!.vorname + " " + driver!.name
        }
        navigationItem.title = vollerName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        numberLabel.text = driver?.nummer
        dateLabel.text = driver?.geburtsdatum
        landLabel.text = driver?.nation
    }
    
}
