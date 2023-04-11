//
//  DetailView.swift
//  TheCat
//
//  Created by İbrahim Güler on 8.04.2023.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel : CatsViewModel
    var cat : Cats
    var animation : Namespace.ID
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                HStack(spacing: 15) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.offsetAnimation = false
                        }
                        withAnimation(.easeInOut(duration: 0.35).delay(0.1)) {
                            viewModel.animateContent = false
                            viewModel.showDetailView = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.7))
                    }
                    
                    Spacer(minLength: 10)
                    
                    Text("\(cat.name ?? "")")
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.trailing, 15)
                
                    Spacer(minLength: 10)
                    
                    if viewModel.isProgressLike {
                        ProgressView()
                            .font(.title2)
                            .foregroundColor(.red.opacity(0.7))
                    } else {
                        Button {
                            withAnimation(.easeOut(duration: 1)) {
                                if viewModel.isLike {
                                    viewModel.deleteFavoriteViaCats(cat: cat)
                                } else {
                                    if let imageId = cat.image?.id {
                                        viewModel.uploadFavCats(imageId: imageId)
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: viewModel.isLike ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(.red.opacity(0.7))
                        }
                    }
                    
                    
                }
                .padding()
                .zIndex(1)
                
                Images(url: cat.image?.url ?? "", size: CGSize(width: getRect().width - 20, height: 320))
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
                    .zIndex(0)
                
                VStack(spacing: 0) {
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        InfoView(title: "Description", subTitle: "\(cat.description ?? "")")
                        InfoView(title: "Origin", subTitle: "\(cat.origin ?? "")")
                        InfoView(title: "Wikipedia URL", subTitle: "\(cat.wikipedia_url ?? "")")
                        InfoView(title: "Life Span", subTitle: "\(cat.life_span ?? "")")
                        InfoView(title: "dog Friendly", subTitle: "\(cat.dog_friendly ?? 0)")
                     
 
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 15)
          
                    
                }
                .padding(.top, 20)
                .padding(.horizontal, 15)
                .padding(.leading, 30)
                .padding(viewModel.animateContent ? 1 : 0)
            }
        }
        .offset(y: viewModel.offsetAnimation ? 0 : 300)
        .opacity(viewModel.offsetAnimation ? 1 : 0)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background{
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .opacity(viewModel.animateContent ? 1 : 0)
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 0.35)) {
                viewModel.animateContent = true
                viewModel.controlCatLike(cat: cat)
            }
            withAnimation(.easeInOut(duration: 0.35).delay(0.1)) {
                viewModel.offsetAnimation = true
            }
            
        }.onChange(of: viewModel.favoriteCats?.count) { newValue in
            viewModel.controlCatLike(cat: cat)
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
