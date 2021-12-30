//
//  ApiClient.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 30.11.2021.
//

import Foundation

enum ApiError: Error {
    case noData
}

// Создание протокола действий приложения при получении данных из сети
protocol DriversApiClient {
    func getDrivers(completion: @escaping (Result<[Driver], Error>) -> Void)
}

// Создание класса, выполняющего данный протокол
class DriversApiClientImpl: DriversApiClient {
    
    /* Задание функции получения данных о гонщиках.
     Входное значение данной функции - замыкание.
     Входное значение замыкания - данные из сети в виде стандартного перечисления Result, которые могут быть либо списком гонщиков, либо ошибкой */
    func getDrivers(completion: @escaping (Result<[Driver], Error>) -> Void) {
        // Инициализация начала работы - запуск сессии для интернет-запроса
        let session = URLSession.shared
        
        // Создание указателя на сайт, с которого будем получать данные
        guard let urlSite = URL(string: "https://ergast.com/api/f1/2021/drivers.json") else {
            return
        }
        
        // Создание указателя на URL для запроса
        let urlRequest = URLRequest(url: urlSite)
        
        // Создание задачи на получение данных из сети
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            
            // Если данные не получены, то вызываем функцию ошибки .failure
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            // Если данные получены, то производим их расшифровку из формата JSON
            let decoder = JSONDecoder()
            do {
                // Расшифровкка JSON и передача данных в data
                let response = try decoder.decode(DriverMRDataDTO.self, from: data)
                completion(.success(response.mrData.driverTable.drivers))
            } catch(let error) {
                // В случае ошибки при расшифровке вывод ошибки
                completion(.failure(error))
                print(error)
            }

        })
        
        // Запуск задачи на получение данных
        dataTask.resume()
    }
}


