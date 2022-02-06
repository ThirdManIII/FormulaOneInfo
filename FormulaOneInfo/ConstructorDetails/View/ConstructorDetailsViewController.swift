//
//  DriversDetailsViewController.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.11.2021.
//

import UIKit

class ConstructorDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var nationLabel: UILabel!
    @IBOutlet var driversForConstList: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var reloadButton: UIButton!
    
    var output: OutputProtocol?
    
    var constructor: Constructor?
    var drivers: [Driver] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath)
        
        let driver = drivers[indexPath.row]
        cell.textLabel?.text = "\(driver.vorname) \(driver.name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "DriverDetailsViewController") as! DriverDetailsViewController
        
        let presenter = DriverDetailsPresenter(viewController: viewController)
        viewController.output = presenter
        
        presenter.driver = drivers[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        
        activityIndicator.startAnimating()
        
        output?.viewDidLoad()
    }

    @IBAction func reloadButtonAction(_ sender: Any) {
        output?.viewDidLoad()
    }
    
}

extension ConstructorDetailsViewController: ConstructorDetailsInputProtocol {
    func showInfo(constructorData: Constructor?) {
        constructor = constructorData
        
        navigationItem.title = constructorData?.name
        nationLabel.text = constructorData?.nation
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func loadData(driversData: [Driver]) {
        drivers = driversData
        self.driversForConstList.reloadData()
        
        self.stopActivityIndicator()
    }
    
    func showErrorMessage() {
        self.driversForConstList.reloadData()
        
        self.stopActivityIndicator()
        
        self.errorLabel.isHidden = false
        self.reloadButton.isHidden = false
    }
    
}
