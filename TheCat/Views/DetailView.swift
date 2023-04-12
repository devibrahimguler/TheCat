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
                
                Images(url: cat.image?.url ?? "", size: CGSize(width: getRect().width - 60, height: 220))
                    .cornerRadius(20)
                    .padding(.horizontal, 30)
                    .zIndex(0)
                
                Divider()
                
                VStack(spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        InfoView(items: [
                            Info(title: "Alt Names", subTitle: "\(cat.alt_names ?? "")"),
                            Info(title: "Description", subTitle: "\(cat.description ?? "")"),
                            Info(title: "Origin", subTitle: "\(cat.origin ?? "") (\(cat.country_codes ?? ""))"),
                            Info(title: "Life Span", subTitle: "\(cat.life_span ?? "")"),
                        ])
                        
                        SubPropertyView(title: "Temperament", subTitle: "\(cat.temperament ?? "")")
                        
                        RatingView(items: [
                            Rating(title: "Indoor", rating: cat.indoor ?? 0),
                            Rating(title: "lap", rating: cat.lap ?? 0),
                            Rating(title: "Adaptability", rating: cat.adaptability ?? 0),
                            Rating(title: "Affection Level", rating: cat.affection_level ?? 0),
                            Rating(title: "Child Friendly", rating: cat.child_friendly ?? 0),
                            Rating(title: "Energy Level", rating: cat.energy_level ?? 0),
                            Rating(title: "grooming", rating: cat.grooming ?? 0),
                            Rating(title: "Health Issues", rating: cat.health_issues ?? 0),
                            Rating(title: "Intelligence", rating: cat.intelligence ?? 0),
                            Rating(title: "Shedding Level", rating: cat.shedding_level ?? 0),
                            Rating(title: "Social Needs", rating: cat.social_needs ?? 0),
                            Rating(title: "Stranger Friendly", rating: cat.stranger_friendly ?? 0),
                            Rating(title: "Vocalisation", rating: cat.vocalisation ?? 0),
                            Rating(title: "Indoor", rating: cat.indoor ?? 0),
                            Rating(title: "Experimental", rating: cat.experimental ?? 0),
                            Rating(title: "Hairless", rating: cat.hairless ?? 0),
                            Rating(title: "Natural", rating: cat.natural ?? 0),
                            Rating(title: "Rare", rating: cat.rare ?? 0),
                            Rating(title: "Rex", rating: cat.rex ?? 0),
                            Rating(title: "Suppressed Tail", rating: cat.suppressed_tail ?? 0),
                            Rating(title: "Short Legs", rating: cat.short_legs ?? 0),
                            Rating(title: "Dog Friendly", rating: cat.dog_friendly ?? 0),
                            Rating(title: "Hypoallergenic", rating: cat.hypoallergenic ?? 0),
                        ])
                        
                        BridgeView(items: [
                            Bridge(title: "Go to Wikipedia", url: "\(cat.wikipedia_url ?? "")"),
                            Bridge(title: "Go to CFA", url: "\(cat.cfa_url ?? "")"),
                            Bridge(title: "Go to Vetstreet", url: "\(cat.vetstreet_url ?? "")"),
                            Bridge(title: "Go to Vcahospitals", url: "\(cat.vcahospitals_url ?? "")"),
                        ])
                   
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 15)
          
                    
                }
                .padding(.top, 20)
                .padding(.horizontal, 15)
                .padding(.leading, 30)
                .padding(viewModel.animateContent ? 1 : 0)
                .background{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.blue.opacity(0.1))
                        .padding(.leading, 30)
                }
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
