//
//  LikesView.swift
//  TheCat
//
//  Created by İbrahim Güler on 10.04.2023.
//

import SwiftUI

struct LikesView: View {
    
    @EnvironmentObject var viewModel : CatsViewModel
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 15) {
                Button {
                    withAnimation{
                        viewModel.showLikeView = false
                        viewModel.searchCats = []
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                }
                
                Spacer(minLength: 10)
                Text("Cats You Like")
                    .foregroundColor(.black)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.trailing, 15)
                Spacer(minLength: 10)
                
            }
            .padding(.horizontal)
            .padding(.top)
            
            if let cats = viewModel.searchCats {
                if cats.isEmpty {
                    VStack{
                        Text("Item not found!")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    GeometryReader {
                        let size = $0.size
                        ScrollView(.vertical, showsIndicators: false) {
                            ListView(cats: cats, animation: animation, size: size)
                                .environmentObject(viewModel)
                     
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .coordinateSpace(name: "SCROLLVIEW")
                        
                    }
                    .padding(.top, 15)
                }
            }
            else {
                ProgressView()
                    .padding(.top, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Color.white
                .ignoresSafeArea()
        }.onChange(of: viewModel.favoriteCats?.count) { newValue in
            viewModel.filterByFavoriteCats()
        }
        .onChange(of: viewModel.showDetailView) { newValue in
            if !newValue {
                withAnimation(.easeInOut(duration: 0.15).delay(0.4)){
                    viewModel.animateCurrentCat = false
                }
            }
        }.onAppear {
            viewModel.filterByFavoriteCats()
        }

    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
