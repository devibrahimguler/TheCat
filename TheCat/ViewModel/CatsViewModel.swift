//
//  CatsViewModel.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation
import UIKit

class CatsListViewModel : ObservableObject {
    
    @Published var cats : [Cats] = [Cats]()
    @Published var seaCats : [Cats] = [Cats]()
    @Published var favCatImgId : [Cats] = [Cats]()
    
    @Published var showDetailView: Bool = false
    @Published var animateCurrentCat: Bool = false
    @Published var animateContent: Bool = false
    @Published var offsetAnimation: Bool = false
    
    @Published var selectedCat: Cats?
    
    let downloaderClient = DownloaderClient()


    
    
    func getCats() {
        DispatchQueue.main.async {
            self.cats = ReadData().cats
        }

        /*
         let url = "https://api.thecatapi.com/v1/breeds"
         downloaderClient.downloadsCats(ofType: Cats.self, url: url) { result in
             switch result {
             case .failure(let error):
                 print(error)
             case .success(let catsArray):
                 if let catsArray = catsArray {
                     DispatchQueue.main.async {
                         self.cats = catsArray.map(CatsViewModel.init)
                     }
                 }
             }
         }
         */
        
    }
    
    func favoriteCats() {
        
        /*
         let url = "https://api.thecatapi.com/v1/favourites?sub_id=gxibrahimxr"
         downloaderClient.downloadsCats(ofType: CatsFavorite.self, url: url) { result in
             switch result {
             case .failure(let error):
                 print(error)
             case .success(let imagesArray):
                 if let imagesArray = imagesArray {
                     DispatchQueue.main.async {
                         self.favCatImgId = imagesArray.map(FavoriViewModel.init)
                     }
                 }
             }
         }
         */
        
    }
    
    func getFavori(cat : Cats) -> Bool {
        for fav in self.favCatImgId {
            if cat.image?.id == fav.image?.id {
                return true
            }
        }
        return false
    }
    
    func getFavId(cat : Cats) -> String {
        for fav in self.favCatImgId {
            if cat.image?.id == fav.image?.id {
                return (fav.image?.id)!
            }
        }
        return ""
    }
    
    func searchCats(name: String) {
        self.seaCats = self.cats
        self.cats.removeAll()
        
        for cat in seaCats {
            if ((cat.name?.starts(with: name)) != nil)
            {
                self.cats.append(cat)
            }
        }
    }
    
    func uploadCats(parameters : String) {
        downloaderClient.uploadFavorite(parameters: parameters)
    }
    
    func deleteCats(imageId : Int) {
        downloaderClient.deleteFavorite(imageId: imageId)
    }
    
    func basicDownloader() {
        self.getCats()
        self.favoriteCats()
    }
}
