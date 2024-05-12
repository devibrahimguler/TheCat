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
    @Published var favoriteCats : [CatsFavorite]?
    
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    
    @Published var showDetailView: Bool = false
    @Published var showLikeView: Bool = false
    
    @Published var isLike: Bool = false
    @Published var isProgressLike: Bool = false
    
    @Published var animateContent: Bool = false
    @Published var animateCurrentCat: Bool = false
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
        
        self.basicDownloader()
        
    }
    
    // Used to get data from Api.
    func filterByCats() {
        DispatchQueue.global(qos: .userInteractive).async {
            if let cats = self.cats {
                let results = cats
                    .lazy
                    .filter { cat in
                        return cat.name!.lowercased().contains(self.searchText.lowercased())
                    }
                
                DispatchQueue.main.async {
                    self.searchCats = results.compactMap { cat in
                        return cat
                    }
                    
                }
            }
            
        }
    }
    
    // Used to get data from Api.
    func filterByFavoriteCats() {
        getFavoriteCats()
        DispatchQueue.global(qos: .userInteractive).async {
            if let cats = self.cats {
                if let favCats = self.favoriteCats {
                    let results = cats
                        .lazy
                        .filter { cat in
                            return favCats.contains { fav in
                                return cat.image?.id == fav.image?.id
                            }
                        }
                    DispatchQueue.main.async {
                        self.searchCats = results.compactMap { cat in
                 
                            return cat
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    // Used to get data from Api.
    func getFavoriteCats() {
        let url = "https://api.thecatapi.com/v1/favourites?sub_id=gxibrahimxr"
        pushPullServices.downloadsCats(ofType: CatsFavorite.self, url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let imagesArray):
                if let imagesArray = imagesArray {
                    DispatchQueue.main.async {
                        self.favoriteCats = imagesArray
                        DispatchQueue.main.async {
                            self.isProgressLike = false
                            
                        }
                    }
                }
            }
        }
    }
    
    func getCatsFromAPI() {
        let url = "https://api.thecatapi.com/v1/breeds"
        pushPullServices.downloadsCats(ofType: Cats.self, url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let catsArray):
                if let catsArray = catsArray {
                    DispatchQueue.main.async {
                        self.cats = catsArray
                    }
                }
            }
        }
    }
    
    func uploadFavCats(imageId : String) {
        DispatchQueue.main.async {
            self.isProgressLike = true
            
        }

        pushPullServices.uploadFavorite(imageId: imageId) { result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let postMessage):
                print(postMessage)
                DispatchQueue.main.async {
                    self.getFavoriteCats()
                }
               
            }
        }
    }
    
    func deleteFavCats(favoriteId : Int) {
        DispatchQueue.main.async {
            self.isProgressLike = true
            
        }
        pushPullServices.deleteFavorite(favoriteId: favoriteId) { result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let postMessage):
                print(postMessage)
                DispatchQueue.main.async {
                    self.getFavoriteCats()
                }
               
            }
        }
        getFavoriteCats()
    }
    
    func controlCatLike(cat: Cats) {
        if let favCats = self.favoriteCats {
            self.isLike = favCats.contains { fav in
                return cat.image?.id == fav.image?.id
            }
        }
    }
    
    func deleteFavoriteViaCats(cat: Cats) {
        if let favoriteId = self.favoriteCats?.first(where: { fav in
            return fav.image?.id == cat.image?.id
        })?.id {
            self.deleteFavCats(favoriteId:  favoriteId)
        }
    }
    
    func basicDownloader() {
        self.getCatsFromAPI()
        self.filterByFavoriteCats()
    }
}
