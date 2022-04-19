//
//  Images.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import SwiftUI

struct Images: View {
    var url : String
    
    @ObservedObject var imageDownloaderClient = ImageDownloaderClient()
    
    init(url : String) {
        self.url = url
        self.imageDownloaderClient.downloadingImage(url: self.url)
        print(url)
    }
    
    var body: some View {
        
        if let data = self.imageDownloaderClient.downloadedImage {
            Image(uiImage: UIImage(data: data)!)
                .resizable()
                .cornerRadius(10)
                .padding(5)
        } else {
            Image("placeholder")
                .resizable()
                .cornerRadius(10)
                .padding(5)
        }
    }
}

struct Images_Previews: PreviewProvider {
    static var previews: some View {
        Images(url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")
    }
}
