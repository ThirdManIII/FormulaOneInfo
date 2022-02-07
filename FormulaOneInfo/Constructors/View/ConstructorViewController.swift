//
//  ConstructorsViewController.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.11.2021.
//

import UIKit

class ConstructorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private var constructorsList: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var reloadButton: UIButton!
    
    var output: OutputProtocol?
    
    var constructors: [Constructor] = []
    
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
        
        let presenter = ConstructorDetailsPresenter(viewController: viewController, apiClient: DriversApiClient())
        viewController.output = presenter
        
        presenter.constructor = constructors[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = ConstructorPresenter(viewController: self, apiClient: ConstructorsApiClient())
        output?.viewDidLoad()
    }
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        output?.reloadButtonDidTapped()
    }
}

extension ConstructorViewController: ConstructorInputProtocol {
    func loadViewElements() {
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        
        activityIndicator.startAnimating()
        
        navigationItem.title = "Constructors"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func loadData(data: [Constructor]) {
        constructors = data
        
        constructorsList.reloadData()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func showErrorMessage() {
        constructorsList.reloadData()
        
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
}
