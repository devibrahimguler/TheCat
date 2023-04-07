//
//  Home.swift
//  TheCat
//
//  Created by İbrahim Güler on 7.04.2023.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewModel : CatsListViewModel

    @State var currentIndex : Int = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(viewModel.cats.indices, id: \.self) { index in
                    GeometryReader { proxy in
                        Images(url: (viewModel.cats[index].image?.url)!, size: proxy.size)
                         
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .cornerRadius(1)
                        /*
                         if let image = self.viewModel.downloadingImage(url: viewModel.cats[index].image) as? UIImage {
                             Image(uiImage: image)
                                 .resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(width: proxy.size.width, height: proxy.size.height)
                                 .cornerRadius(1)
                         } else {
                             Image("placeholder")
                         }
                         */
                        
                        
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
        
                ], startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
            
            SnapCarousel(spacing: getRect().height < 750 ? 15 : 20,trailingSpace: getRect().height < 750 ? 100 : 130,index: $currentIndex, items: viewModel.cats) { cat in
                CardView(cat: cat)
            }
            .offset(y: getRect().height / 3.5)
        }
        .onAppear {
            self.viewModel.basicDownloader()
            self.viewModel.favoriteCats()
        }
        
    }
    
    @ViewBuilder
    func CardView(cat: CatsViewModel) -> some View {
        VStack(spacing: 10) {
            GeometryReader {proxy in
                Images(url: cat.image, size: proxy.size)
    
                
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(25)
            .frame(height: getRect().height / 2.5)
            .padding(.bottom, 15)
            
            Text(cat.name)
                .font(.title2.bold())
                .lineLimit(1)
            
            
            Text(cat.description)
                .font(getRect().height < 750 ? .caption : .callout)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.top,8)
                .padding(.horizontal)
            
            Button {
                viewModel.showDetailView = true
            } label: {
                Text("Learn More")
            }

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
