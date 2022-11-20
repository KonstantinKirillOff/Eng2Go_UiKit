//
//  NetworkManager.swift
//  Eng2Go
//
//  Created by Konstantin Kirillov on 12.10.2022.
//

import Foundation

enum NetworcErrors: Error {
    case badURL
    case badData
    case decodeError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchURLUnslashImage(for wordOnEnglish: String, complitionHandler: @escaping (Result<String, NetworcErrors>) -> Void) {
        let key = "LUMG6YSLoGTass_HzRDzERd_dmrCMBSHpxqku6yl7P8"
        let query = wordOnEnglish.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(key)") else {
            complitionHandler(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                complitionHandler(.failure(.badData))
                return
            }
            
            do {
                let picturesForRequesr = try JSONDecoder().decode(UnsplashResponse.self, from: data)
                if picturesForRequesr.results.count > 0 {
                    DispatchQueue.main.async {
                        complitionHandler(.success(picturesForRequesr.results.randomElement()!.urls["thumb"]!))
                    }
                }
            } catch {
                complitionHandler(.failure(.decodeError))
            }
        }.resume()
    }
    
    private init() {}
}
