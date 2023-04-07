//
//  ImageDownloaderClient.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation
import SwiftUI

final class ImageDownloaderClient : ObservableObject {
    
    @Published var downloadedImage : UIImage?
    
    private let cache = NSCache<NSString, UIImage>()
    
    
    func downloadingImage(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data , error == nil else { return }
            if let image = self.cache.object(forKey: "\(url)" as NSString) {
                self.downloadedImage = image
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    self.downloadedImage = nil
                    return
                }
                self.cache.setObject(image, forKey: "\(url)" as NSString)
                self.downloadedImage = image
            }
        }.resume()
    }
    
    /*
     func downloadingImage(url: String) {
         guard let imageUrl = URL(string: url) else { return }
         
         URLSession.shared.dataTask(with: imageUrl) { data, response, error in
             guard let data = data , error == nil else { return }

             DispatchQueue.main.async {
       
                 self.downloadedImage = data
             }
         }.resume()
     }
     */
    
}
