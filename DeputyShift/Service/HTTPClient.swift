//
//  HTTPClient.swift
//  DeputyShift
//
//  Created by Clayton on 24/2/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

enum ShiftType: String {
    case start
    case end
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
     
            let decoder =  JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let shiftsDetail = try? decoder.decode(ShiftList.self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(shiftsDetail))
            
        }.resume()
    }
    
    func postShift(shift: ShiftPost, shiftType: ShiftType, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let url = URL.postShift(shiftType: shiftType) else{
            return completion(.failure(.badURL))
        }
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(shift)
//        let json = String(data: jsonData!, encoding: String.Encoding.utf8)
//        print(json)
        
        print (url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Deputy " + Constants.SHA1NAME, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            let str = String(decoding: data!, as: UTF8.self)
            print(str)
            
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            
            completion(.success(str))
            
        }.resume()
    }
    
    
}
