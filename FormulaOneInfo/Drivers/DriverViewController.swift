//
//  ViewController.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 28.11.2021.
//

import UIKit

class DriverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // UITableViewDelegate, UITableViewDataSource указывают, что DriversViewController будет источником данных для TableView
    @IBOutlet var driversList: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var reloadButton: UIButton!
    
    var drivers: [Driver] = []
    
    let apiClient: DriversApiClient = DriversApiClientImpl()
    
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
        
        viewController.driver = drivers[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
        
        // Убираем выделение ячейки
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
        
        // Инициализация и назначение стиля титульной надписи
        navigationItem.title = "Drivers"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        apiClient.getDrivers(completion: { [self] result in
            
            // Выводим выполнение кода в главный поток
            DispatchQueue.main.async {
                switch result {
                case .success(let drivers):
                    self.drivers = drivers
                    self.driversList.reloadData()
                    
                    stopActivityIndicator()
                case .failure:
                    self.drivers = []
                    self.driversList.reloadData()
                    
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

