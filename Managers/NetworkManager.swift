//
//  NetworkManager.swift
//  Cars Test App
//
//  Created by Юра Гейц on 01.04.2022.
//

import Foundation

class NetworkManager {
    
    private let urlString = "http://filehost.feelsoftware.com/jsonplaceholder/cars-api.php"
    
    private init(){}
    static let shared = NetworkManager()
    
    var onCompletion: ((Cars) -> ())?
    
    func getCars() {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let cars = self.parseJSON(withData: data) {
                    self.onCompletion?(cars)
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> Cars? {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let responseCarsData = try decoder.decode(Cars.self, from: data)
            return responseCarsData
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
}
