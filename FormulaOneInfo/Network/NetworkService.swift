//
//  DriversForConstructor.swift
//  FormulaOneInfo
//
//  Created by Vladislav Kuchurin on 06.12.2021.
//

import Foundation

enum ApiError: Error {
    case noData
}

protocol NetworkService {
    func dataReceiving<T: Decodable>(url: String, decodeStruct: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkServiceImpl: NetworkService {
    
    /* Задание функции получения данных.
     Входные значения данной функции - адрес URL, структура-адресат, замыкание обработки результата.
     Входное значение замыкания - данные из сети в виде стандартного перечисления Result, которые могут быть либо успешно полученными данными, либо ошибкой */
    func dataReceiving<T: Decodable>(url: String, decodeStruct: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        // Инициализация начала работы - запуск сессии для интернет-запроса
        let session = URLSession.shared
        
        // Создание указателя на сайт, с которого будем получать данные
        guard let urlSite = URL(string: url) else {
            return
        }
        
        // Создание указателя на URL для запроса
        let urlRequest = URLRequest(url: urlSite)
        
        // Создание задачи на получение данных из сети
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            guard data != nil else {
                // Если данные не получены, то вызываем кейс ошибки Result.failure
                completion(.failure(ApiError.noData))
                return
            }
            
            // Если данные получены, то производим их расшифровку из формата JSON
            let decoder = JSONDecoder()
            do {
                // Расшифровкка JSON и передача данных в data
                let response = try decoder.decode(decodeStruct.self, from: data!)
                completion(.success(response))
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
