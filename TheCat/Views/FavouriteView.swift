//
//  FavouriteView.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import SwiftUI

struct FavouriteView: View {
    
    @EnvironmentObject var viewModel : CatsListViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                ForEach(self.viewModel.cats){ cat in
                    if self.viewModel.getFavori(cat: cat) {
                     
                     
                            
                            HStack {
                                NavigationLink {
                                    CatDetailView(cat: cat)
                                        .environmentObject(viewModel)
                                } label: {
                                    HStack {
                                       
                                        
                                        Text(cat.name)
                                            .frame(width: UIScreen.main.bounds.width * 0.3)
                                    }.frame(width: UIScreen.main.bounds.width * 0.6)
                                }

                                
                                
                                Button {
                                    self.viewModel.deleteCats(imageId: self.viewModel.getFavId(cat: cat))
                                    Thread.sleep(forTimeInterval: 0.1)
                                    self.viewModel.favoriteCats()
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
        ContentView()
    }
}
