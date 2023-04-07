//
//  SearchCats.swift
//  TheCat
//
//  Created by İbrahim Güler on 16.04.2022.
//

import SwiftUI

struct SearchCats: View {
    @EnvironmentObject var viewModel : CatsListViewModel
    @Namespace private var animation
    @State var searchingName = ""
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                TextField("Arama", text: self.$searchingName, onEditingChanged: { _ in}, onCommit: {
                    if self.searchingName != "" {
                        self.viewModel.searchCats(name: self.searchingName)
                    } else {
                        self.viewModel.getCats()
                    }
                }).padding(.horizontal, 10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Image("search")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, 25)
            }
            
            GeometryReader {
                let size = $0.size
                ScrollView(.vertical, showsIndicators: false) {
                

                    ListView(cats: viewModel.cats, animation: animation, size: size)
                        .environmentObject(viewModel)
                }
                .coordinateSpace(name: "SCROLLVIEW")
                
            }
            .padding(.top, 15)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            self.viewModel.basicDownloader()
            self.viewModel.favoriteCats()
        }
    }
}

struct SearchCats_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}
