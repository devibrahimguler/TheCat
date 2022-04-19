//
//  CatsViewModel.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation
import SwiftUI

class CatsListViewModel : ObservableObject {
    
    @Published var cats : [CatsViewModel] = [CatsViewModel]()
    @Published var seaCats : [CatsViewModel] = [CatsViewModel]()
    @Published var favCatImgId : [FavoriViewModel] = [FavoriViewModel]()
    
    let downloaderClient = DownloaderClient()
    
    func getCats() {
        downloaderClient.downloadsCats() { result in
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
    }
    
    func favoriteCats() {
        downloaderClient.downloadsFavorite { result in
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
    }
    
    func getFavori(cat : CatsViewModel) -> Bool {
        for fav in self.favCatImgId {
            if cat.imageId == fav.imageId {
                return true
            }
        }
        return false
    }
    
    func getFavId(cat : CatsViewModel) -> Int {
        for fav in self.favCatImgId {
            if cat.imageId == fav.imageId {
                return fav.id
            }
        }
        return -1
    }
    
    func searchCats(name: String) {
        self.seaCats = self.cats
        self.cats.removeAll()
        
        for cat in seaCats {
            if (cat.name.starts(with: name))
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

struct ImageViewModel {
    
    let img : CatsImages
    
    var id : String {
        img.id ?? ""
    }
    
    var url : String {
        img.url ?? ""
    }
}

struct FavoriViewModel {
    
    let fav : CatsFavorite
    
    var id : Int {
        fav.id
    }
    
    var imageId : String {
        fav.image?.id ?? ""
    }
    
    var url : String {
        fav.image?.url ?? ""
    }
}

struct CatsViewModel {
    
    let cats : Cats
    
    var id : String {
        cats.id ?? ""
    }
    
    var image : String {
        cats.image?.url ?? ""
    }
    
    var imageId : String {
        cats.image?.id ?? ""
    }
    
    var name : String {
        cats.name ?? ""
    }
    
    var description : String {
        cats.description ?? ""
    }
    
    var origin : String {
        cats.origin ?? ""
    }
    
    var wikipedia_url : String {
        cats.wikipedia_url ?? ""
    }
    
    var life_span : String {
        cats.life_span ?? ""
    }
    
    var dog_friendly : Int {
        cats.dog_friendly ?? 0
    }
}

struct SearchViewModel {
    
    let cats : Cats
    
    var id : String {
        cats.id ?? ""
    }
    
    var image : String {
        cats.image?.url ?? ""
    }
    
    var imageId : String {
        cats.image?.id ?? ""
    }
    
    var name : String {
        cats.name ?? ""
    }
    
    var description : String {
        cats.description ?? ""
    }
    
    var origin : String {
        cats.origin ?? ""
    }
    
    var wikipedia_url : String {
        cats.wikipedia_url ?? ""
    }
    
    var life_span : String {
        cats.life_span ?? ""
    }
    
    var dog_friendly : Int {
        cats.dog_friendly ?? 0
    }
}
