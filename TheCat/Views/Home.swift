//
//  Home.swift
//  TheCat
//
//  Created by İbrahim Güler on 7.04.2023.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewModel : CatsViewModel
    @Namespace private var animation
    @State var currentIndex : Int = 0
    
    @GestureState var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            if viewModel.cats?.count == 0 {
                PlaceHolder()
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(viewModel.cats?.indices ?? [Cats]().indices, id: \.self) { index in
                        GeometryReader { proxy in
                            Images(url: viewModel.cats?[index].image?.url ?? "", size: proxy.size)
                        }
                        .ignoresSafeArea()
                        .offset(y: -100)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentIndex)
                .overlay {
                    LinearGradient(colors: [
                        Color.clear,
                        Color.black.opacity(0.2),
                        Color.white.opacity(0.4),
                        Color.white,
                        Color.white,
                        Color.white,
            
                    ], startPoint: .top, endPoint: .bottom)
                }
                .ignoresSafeArea()
                
                SnapCarousel(spacing: getRect().height < 750 ? 15 : 20,trailingSpace: getRect().height < 750 ? 100 : 130,index: $currentIndex, items: viewModel.cats ?? []) { cat in
                    CardView(cat: cat)
                }
                .offset(y: getRect().height / 3.5)
                
                VStack {
                    Spacer()
                    HStack(spacing: 15) {
                        
                        ZStack {
                            LikeBar()
                        }
                        .frame(width: getRect().width / 3)
                            .padding(.leading, 5)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    viewModel.showLikeView = true
                                }
                            }
                        
                        ZStack {
                            if viewModel.searchActivated {
                                SearchBar()
                                  
                            } else {
                                SearchBar()
                                    .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                            }
                            
                        }
                        .frame(width: getRect().width / 3)
                        .padding(.horizontal, 5)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                viewModel.searchActivated = true
                                viewModel.selectedCat = nil
                            }
                        }
                        
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .bottom)
                    .padding (.horizontal, 15)
                }
            }
        }
        .overlay(content: {
            ZStack {
                if viewModel.showLikeView {
                    LikesView(animation: animation)
                        .environmentObject(viewModel)
                      
                }
                if viewModel.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(viewModel)
                      
                }
                if viewModel.showDetailView {
                    DetailView(cat: viewModel.selectedCat!, animation: animation)
                        .environmentObject(viewModel)
                      
                }
            }
        })
        
    }
    
    @ViewBuilder
    func CardView(cat: Cats) -> some View {
        VStack(spacing: 10) {
            GeometryReader {proxy in
                Images(url: cat.image?.url ?? "", size: proxy.size)
                    .cornerRadius(25)
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(25)
            .frame(height: getRect().height / 2.5)
            .padding(.bottom, 15)
         
            
            Text(cat.name!)
                .font(.title2.bold())
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .lineLimit(1)

            Text(cat.description!)
                .font(getRect().height < 750 ? .caption : .callout)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.top,8)
                .padding(.horizontal)
    
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.selectedCat = cat
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        viewModel.showDetailView = true
                        viewModel.offsetAnimation = false
                    }
                }
            } label: {
                Text("Read More")
            }

        }
    }
    
    
    // SearchBar View.
    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            if !(getRect().height < 750) {
                TextField("",text: .constant("search"))
                    .disabled(true)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.2))
                
        }
        
    }
    
    // SearchBar View.
    @ViewBuilder
    func LikeBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "heart")
                .font(.title2)
                .foregroundColor(.gray)
            
            if !(getRect().height < 750) {
                TextField("",text: .constant("Likes"))
                    .disabled(true)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical,12)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.red.opacity(0.2))
                
        }
        
    }
    
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}


