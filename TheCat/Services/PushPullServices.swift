//
//  DownloaderClient.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation
import UIKit

final class PushPullServices {
    
    func downloadsCats<T:Decodable>(ofType: T.Type,url: String,completion : @escaping (Result<[T]?, DownloadError>) -> Void)
    where T: DataModel{
        var request = URLRequest(url: URL(string: url )!,timeoutInterval: Double.infinity)

        if !(T.Type.self == Cats.Type.self) {
            request.cachePolicy = .useProtocolCachePolicy
        }
    
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["content-type": "application/json", "x-api-key": "eee91339-815d-4910-89cb-77a5c6fd0d4f"]
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.dontCatchData))
            }
            
            
            guard let catsResponse = try? JSONDecoder().decode([T].self, from: data) else {
                return completion(.failure(.dontHandeData))
            }
            
            completion(.success(catsResponse))
        }.resume()
        
    }
    
    func uploadFavorite(parameters : String) {
        
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites")!,timeoutInterval: Double.infinity)
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
