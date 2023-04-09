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
    var isList : Bool
  
    init(url: String, size: CGSize, isList : Bool = false) {

        self.url = url
        self.size = size
        self.isList = isList
    }
   
    var body: some View{
        VStack(spacing: 0) {
            if let image = self.imageDownloaderClient.downloadedImage {
                if isList {
                    image
                        .listModifier(size: size)
                } else {
                    image
                        .carouselModifier(size: size)
                }
            }else {
                if isList {
                    Image("placeholder")
                        .listModifier(size: size)
                } else {
                    Image("placeholder")
                        .carouselModifier(size: size)
                }
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

extension Image {
    
    func listModifier(size: CGSize) -> some View {
        return self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width / 2, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 5,x: 5,y: 5)
            .shadow(color: .black.opacity(0.1), radius: 5,x: -5,y: -5)
   }
    
    func carouselModifier(size: CGSize) -> some View {
        return self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .cornerRadius(1)
   }
}

