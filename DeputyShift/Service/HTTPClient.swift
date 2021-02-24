//
//  HTTPClient.swift
//  DeputyShift
//
//  Created by Clayton on 24/2/21.
//

import Foundation

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class HTTPClient {
    
    func getShifts(completion: @escaping (Result<ShiftList, NetworkError>) -> Void) {
        
        guard let url = URL.getShifts() else{
            return completion(.failure(.badURL))
        }
        

        print (url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Deputy " + Constants.SHA1NAME, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request){ data, response, error in
            
            let str = String(decoding: data!, as: UTF8.self)
            print(str)
            
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
     
            guard let shiftsDetail = try? JSONDecoder().decode(ShiftList.self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(shiftsDetail))
            
        }.resume()
    }
}
