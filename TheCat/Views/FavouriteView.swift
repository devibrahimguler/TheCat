//
//  FavouriteView.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import SwiftUI

struct FavouriteView: View {
    
    @ObservedObject var catsListViewModel : CatsListViewModel
    
    init(catsListViewModel : CatsListViewModel) {
        self.catsListViewModel = catsListViewModel
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                ForEach(self.catsListViewModel.cats, id:\.id ){ cat in
                    if self.catsListViewModel.getFavori(cat: cat) {
                            Divider()
                                .padding(.leading,30)
                            
                            HStack {
                                NavigationLink {
                                    CatDetailView(cat: cat, catsListViewModel: catsListViewModel)
                                } label: {
                                    HStack {
                                        Images(url: cat.image)
                                            .frame(width: 80, height: 80)
                                        
                                        
                                        Text(cat.name)
                                            .frame(width: UIScreen.main.bounds.width * 0.3)
                                    }.frame(width: UIScreen.main.bounds.width * 0.6)
                                }

                                
                                
                                Button {
                                    self.catsListViewModel.deleteCats(imageId: self.catsListViewModel.getFavId(cat: cat))
                                    Thread.sleep(forTimeInterval: 0.1)
                                    self.catsListViewModel.favoriteCats()
                                } label: {
                                    Image("heart-1")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    
                                }.frame(width: UIScreen.main.bounds.width * 0.2)
                                    
                            }
                            Divider()
                                .padding(.leading,30)
                        
                    }
                }
            }
        })
        .frame(width: UIScreen.main.bounds.width)
        
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        Test_FavouriteView()
    }
    
    struct Test_FavouriteView : View {
        var catsListViewModel = CatsListViewModel()
        
        var body: some View {
            FavouriteView(catsListViewModel: catsListViewModel)
        }
    }
}
