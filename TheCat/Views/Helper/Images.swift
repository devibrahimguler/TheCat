//
//  Images.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import SwiftUI

struct Images: View {
    
    @StateObject var imageDownloaderClient : ImageDownloaderClient = ImageDownloaderClient()
    var url : String
    var size : CGSize

    init(url: String, size: CGSize) {

        self.url = url
        self.size = size
       
        
    }
   
    var body: some View {
        VStack(spacing: 0) {
            if let image = self.imageDownloaderClient.downloadedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(25)
            }else {
                Image("placeholder")
            }
        }.onAppear {
            DispatchQueue.main.async {
                imageDownloaderClient.downloadingImage(url: url)
            }
        }
    }
    
    
}

struct Images_Previews: PreviewProvider {
    static var previews: some View {
        Images(url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg", size: CGSize(width: 200, height: 200))
    }
}

