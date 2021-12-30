//
//  ConstructorsViewController.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.11.2021.
//

import UIKit

class ConstructorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var constructorsList: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var reloadButton: UIButton!
    
    var constructors: [Constructor] = []
    
    let apiClient: ConstructorsApiClient = ConstructorsApiClientImpl()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constructors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConstructorCell", for: indexPath)
        
        let constructor = constructors[indexPath.row]
        cell.textLabel?.text = constructor.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConstructorDetailsViewController") as! ConstructorDetailsViewController
        
        viewController.constructor = constructors[indexPath.row]
        
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
        
        navigationItem.title = "Constructors"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        apiClient.getConstructors(completion: { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let constructors):
                    self.constructors = constructors
                    self.constructorsList.reloadData()
                    
                    stopActivityIndicator()
                case .failure:
                    self.constructors = []
                    self.constructorsList.reloadData()
                    
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
