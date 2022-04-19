//
//  ImageDownloaderClient.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation

class ImageDownloaderClient : ObservableObject {
    
    @Published var downloadedImage : Data?
    
    func downloadingImage (url: String) {
        guard let imageUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data , error == nil else { return }
            
            DispatchQueue.main.async {
                self.downloadedImage = data
            }
        }.resume()
    }
}
