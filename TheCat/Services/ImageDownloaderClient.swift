//
//  ImageDownloaderClient.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation
import SwiftUI

final class ImageDownloaderClient : ObservableObject {
    
    @Published var downloadedImage : Image?
    
    private let cache = NSCache<NSString, UIImage>()
    
    func downloadingImage(cat: Cats) {
        guard let imageUrl = URL(string: cat.image?.url ?? "") else { return }
        if let image = self.cache.object(forKey: cat.id! as NSString) {
            DispatchQueue.main.async {
                self.downloadedImage = Image(uiImage: image)
            }
        }
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data , error == nil else { return }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    self.downloadedImage = nil
                    return
                }
                self.cache.setObject(image, forKey: cat.id! as NSString)
                self.downloadedImage = Image(uiImage: image)
            }
        }
        
        task.resume()
    }
    
}
