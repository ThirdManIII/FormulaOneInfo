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
    
    let apiClient: ConstructorsApiClient = ConstructorsApiClientImpl()
    
    var constructor: Constructor?
    var driversForConstructor: [Driver] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return driversForConstructor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath)
        
        let driver = driversForConstructor[indexPath.row]
        cell.textLabel?.text = "\(driver.vorname) \(driver.name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "DriverDetailsViewController") as! DriverDetailsViewController
        
        viewController.driver = driversForConstructor[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    var navigationItemTitle:  String?
    var nationText: String?
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if navigationItemTitle == nil {
            navigationItem.title = constructor?.name
        
            nationLabel.text = constructor?.nation
        } else {
            navigationItem.title = navigationItemTitle
            
            nationLabel.text = nationText
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        
        activityIndicator.startAnimating()
        
        apiClient.getDriversForConstructor(constructorName: constructor!.constructorId, completion: { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let drivers):
                    self.driversForConstructor = drivers
                    self.driversForConstList.reloadData()
                    
                    stopActivityIndicator()
                case .failure:
                    self.driversForConstructor = []
                    self.driversForConstList.reloadData()
                    
                    stopActivityIndicator()
                    
                    errorLabel.isHidden = false
                    reloadButton.isHidden = false
                }
            }
        })
    }

    @IBAction func reloadButtonAction(_ sender: Any) {
        viewDidLoad()
    }
    
}
