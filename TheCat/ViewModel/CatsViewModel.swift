//
//  CatsViewModel.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import Foundation
import UIKit
import Combine

class CatsViewModel : ObservableObject {
    
    @Published var cats : [Cats]?
    @Published var searchCats : [Cats]?
    @Published var favCatImgId : [Cats] = []
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    
    @Published var showDetailView: Bool = false
    
    @Published var animateCurrentCat: Bool = false
    @Published var animateContent: Bool = false
    @Published var offsetAnimation: Bool = false
    
    @Published var selectedCat: Cats?
    
    let pushPullServices : PushPullServices = PushPullServices()
    
    private var searchCancellable: AnyCancellable?
    
    init() {
        self.searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterByCats()
                } else {
                    self.searchCats = nil
                }
            })
    }
    
    // Used to get data from CoreData.
    func filterByCats() {
        DispatchQueue.global(qos: .userInteractive).async {
            if let cats = self.cats {
                let results = cats
                    .lazy
                    .filter { cat in
                        return cat.name!.lowercased().contains(self.searchText.lowercased())
                    }
                
                DispatchQueue.main.async {
                    self.searchCats = results.compactMap { mission in
                        return mission
                    }
                    
                }
            }
            
        }
    }
    
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
    
    func uploadCats(parameters : String) {
        pushPullServices.uploadFavorite(parameters: parameters)
    }
    
    func deleteCats(imageId : Int) {
        pushPullServices.deleteFavorite(imageId: imageId)
    }
    
    func basicDownloader() {
        self.getCats()
        self.favoriteCats()
    }
}
