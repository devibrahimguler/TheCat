//
//  DownloaderClient.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation

class DownloaderClient {
    
    func downloadsCats(completion : @escaping (Result<[Cats]?, DownloadError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/breeds" )!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["x-api-key": "eee91339-815d-4910-89cb-77a5c6fd0d4f"]
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.dontCatchData))
            }
            
            guard let catsResponse = try? JSONDecoder().decode([Cats].self, from: data) else {
                return completion(.failure(.dontHandeData))
            }
            
            completion(.success(catsResponse))
        }.resume()
    }
    
    func downloadsFavorite(completion : @escaping (Result<[CatsFavorite]?, DownloadError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites?sub_id=gxibrahimxr")!,cachePolicy: .useProtocolCachePolicy,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["x-api-key": "eee91339-815d-4910-89cb-77a5c6fd0d4f"]
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.dontCatchData))
            }
            
            guard let imagesResponse = try? JSONDecoder().decode([CatsFavorite].self, from: data) else {
                return completion(.failure(.dontHandeData))
            }
            
            completion(.success(imagesResponse))
        }.resume()
    }
    
    func uploadFavorite(parameters : String) {
        
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("DEMO-API-KEY", forHTTPHeaderField: "eee91339-815d-4910-89cb-77a5c6fd0d4f")
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["content-type": "application/json","x-api-key": "eee91339-815d-4910-89cb-77a5c6fd0d4f"]
        request.httpBody = postData
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            print(String(data: data, encoding: .utf8)!)
            
        }.resume()
    }
    
    func deleteFavorite(imageId : Int) {
        
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites/\(imageId)")!,timeoutInterval: Double.infinity)

        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = ["content-type": "application/json","x-api-key": "eee91339-815d-4910-89cb-77a5c6fd0d4f"]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            print(String(data: data, encoding: .utf8)!)
            
        }.resume()
    }
}

enum DownloadError : Error {
    case dontCatchData
    case dontHandeData
}
