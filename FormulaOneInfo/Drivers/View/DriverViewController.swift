//
//  ViewController.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 28.11.2021.
//

import UIKit

class DriverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // UITableViewDelegate, UITableViewDataSource указывают, что DriversViewController будет источником данных для TableView
    @IBOutlet private var driversList: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var reloadButton: UIButton!
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        output?.reloadButtonDidTapped()
    }
    
    var output: OutputProtocol?
    
    var drivers: [Driver] = []
    
    // Функция для задания количества ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    
    // Функция для задания количества ячеек (cell) в секции и инициализации ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath)
        
        let driver = drivers[indexPath.row]
        cell.textLabel?.text = "\(driver.vorname) \(driver.name)"
        
        return cell
    }
    
    // Инициализация нового ViewController при нажатии на ячейку таблицы и передача данных из массива drivers в новый ViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        // При прописывании ViewController без "as!" ему присваивается базовый класс UIViewController. Для получения возможности переноса данных нужно дописать дополнение с "as!".
        let viewController = storyboard.instantiateViewController(withIdentifier: "DriverDetailsViewController") as! DriverDetailsViewController
        
        let presenter = DriverDetailsPresenter(viewController: viewController)
        viewController.output = presenter
        
        presenter.driver = drivers[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
        
        // Убираем выделение ячейки
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output = DriverPresenter(viewController: self, apiClient: DriversApiClient())
        output?.viewDidLoad()
    }
    
}

extension DriverViewController: DriverInputProtocol {
    func loadViewElements() {
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        
        activityIndicator.startAnimating()
        
        // Инициализация и назначение стиля титульной надписи
        navigationItem.title = "Drivers"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func loadData(data: [Driver]) {
        drivers = data
        
        driversList.reloadData()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func showErrorMessage() {
        driversList.reloadData()
        
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
}

