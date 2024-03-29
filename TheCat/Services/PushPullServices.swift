//
//  DownloaderClient.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation
import UIKit

final class PushPullServices {
    
    func downloadsCats<T:Decodable & DataModel>(ofType: T.Type,url: String,completion : @escaping (Result<[T]?, DownloadError>) -> Void){
        var request = URLRequest(url: URL(string: url )!,timeoutInterval: Double.infinity)

        if !(T.Type.self == Cats.Type.self) {
            request.cachePolicy = .useProtocolCachePolicy
        }
    
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["content-type": "application/json", "x-api-key": APIKey().xapikey]
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.dontCatchData))
            }
            
            guard let catsResponse = try? JSONDecoder().decode([T].self, from: data) else {
                return completion(.failure(.dontHandleData))
            }

            completion(.success(catsResponse))
        }.resume()
        
    }
    
    func uploadFavorite(imageId : String, completion : @escaping (Result<String, PostError>) -> Void) {
        
        let values = ["image_id":"\(imageId)","sub_id":"gxibrahimxr"]
        guard let postData =  try? JSONSerialization.data(withJSONObject: values) else {
            return completion(.failure(.dontConvertData))
        }
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["content-type": "application/json","x-api-key":  APIKey().xapikey]
        request.addValue("gxibrahimxr", forHTTPHeaderField: "sub_id")
        request.httpBody = postData
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.dontPostData))
            }
            completion(.success(String(data: data, encoding: .utf8)!))
            
        }.resume()
    }
    
    func deleteFavorite(favoriteId : Int, completion : @escaping (Result<String, PostError>) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/favourites/\(favoriteId)")!,timeoutInterval: Double.infinity)

        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = ["content-type": "application/json","x-api-key":  APIKey().xapikey]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return completion(.failure(.dontPostData)) }
            
            completion(.success(String(data: data, encoding: .utf8)!))
            
        }.resume()
    }
}

enum DownloadError : Error {
    case dontCatchData
    case dontHandleData
}

enum PostError : Error {
    case dontConvertData
    case dontPostData
}

