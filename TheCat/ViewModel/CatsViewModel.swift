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
                    }
                }
            }
        }
    }
    
    func getCats() {
        DispatchQueue.main.async {
            self.cats = ReadData().cats
        }
        
    }
    
    func uploadFavCats(imageId : String) {
        DispatchQueue.main.async {
            self.isProgressLike = false
            
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
    
    func deleteFavCats(catId : String) {
        pushPullServices.deleteFavorite(catId: catId)
        getFavoriteCats()
    }
    
    func basicDownloader() {
        self.getCats()
        self.filterByFavoriteCats()
    }
}
