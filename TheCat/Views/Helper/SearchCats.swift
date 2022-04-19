//
//  SearchCats.swift
//  TheCat
//
//  Created by İbrahim Güler on 16.04.2022.
//

import SwiftUI

struct SearchCats: View {
    @ObservedObject var catsListViewModel : CatsListViewModel
    
    @State var searchingName = ""
    
    init(catsListViewModel : CatsListViewModel) {
        self.catsListViewModel = catsListViewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        TextField("Arama", text: self.$searchingName, onEditingChanged: { _ in}, onCommit: {
                            if self.searchingName != "" {
                                self.catsListViewModel.searchCats(name: self.searchingName)
                            } else {
                                self.catsListViewModel.getCats()
                            }
                        }).padding(.horizontal, 10)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Image("search")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .aspectRatio(contentMode: .fit)
                            .padding(.trailing, 25)
                    }
                    
                    
                    ForEach(self.catsListViewModel.cats, id: \.id) { cat in
                        Divider()
                            .padding(.leading,30)
                        
                        HStack{
                            NavigationLink {
                                CatDetailView(cat: cat, catsListViewModel: catsListViewModel)
                            } label: {
                                HStack {
                                    
                                    Images(url: cat.image)
                                        .frame(width: 80, height: 80)
                                    
                                    Text(cat.name)
                                        .frame(width: UIScreen.main.bounds.width * 0.3)
                                    
                                }
                            }.frame(width: UIScreen.main.bounds.width * 0.7)
                            
                            Button {
                                if !self.catsListViewModel.getFavori(cat: cat) {
                                    
                                    self.catsListViewModel.uploadCats(parameters: "{\n\t\"image_id\":\"\(cat.imageId)\",\n\t\"sub_id\": \"gxibrahimxr\"\n}")
                                    Thread.sleep(forTimeInterval: 0.1)
                                    self.catsListViewModel.favoriteCats()
                                    
                                } else {
                                    
                                    self.catsListViewModel.deleteCats(imageId: self.catsListViewModel.getFavId(cat: cat))
                                    Thread.sleep(forTimeInterval: 0.1)
                                    self.catsListViewModel.favoriteCats()
                                    
                                }
                                
                            } label: {
                                
                                Image(self.catsListViewModel.getFavori(cat: cat) ? "heart-1" : "heart")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }.frame(width: UIScreen.main.bounds.width * 0.2)
                        }
                        
                        Divider()
                            .padding(.leading,30)
                    }.frame(width: UIScreen.main.bounds.width)
                    
                }.navigationTitle("CatBreeds")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        NavigationLink {
                            FavouriteView(catsListViewModel: catsListViewModel)
                        } label: {
                            HStack {
                                Image("heart-1")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                                
                            }
                        }
                        
                    }
            }
        }
        .animation(.easeInOut)
        .onAppear {
            self.catsListViewModel.basicDownloader()
            self.catsListViewModel.favoriteCats()
        }
    }
}

struct SearchCats_Previews: PreviewProvider {
    static var previews: some View {
        Test_SearchCats()
    }
    
    struct Test_SearchCats : View {
        var body: some View {
            SearchCats(catsListViewModel: CatsListViewModel())
        }
    }
    
}
