//
//  DriversDetailsViewController.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 29.11.2021.
//

import UIKit

class ConstructorDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var nationLabel: UILabel!
    @IBOutlet private var driversForConstList: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var reloadButton: UIButton!
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
        guard let viewController =
                storyboard.instantiateViewController(
                    withIdentifier: "DriverDetailsViewController"
                ) as? DriverDetailsViewController
        else {
            return
        }
        let presenter = DriverDetailsPresenter(viewController: viewController)
        viewController.output = presenter
        presenter.driver = drivers[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }

    @IBAction func reloadButtonAction(_ sender: Any) {
        output?.reloadButtonDidTapped()
    }
}

extension ConstructorDetailsViewController: ConstructorDetailsInputProtocol {
    func loadViewElements() {
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        activityIndicator.startAnimating()
    }
    func showInfo(constructorData: Constructor?) {
        constructor = constructorData
        navigationItem.title = constructorData?.name
        nationLabel.text = constructorData?.nation
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func loadData(driversData: [Driver]) {
        drivers = driversData
        self.driversForConstList.reloadData()
    }
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    func showErrorMessage() {
        driversForConstList.reloadData()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
}
