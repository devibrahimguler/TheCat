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
                        withAnimation{
                            viewModel.showDetailView = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.7))
                    }
                    
                    Spacer(minLength: 10)
                
                    
                }
                .padding()
                
                
                GeometryReader {
                    let size = $0.size
                    
                    HStack(spacing: 20) {
                        
                        Images(url: cat.image?.url ?? "", size: CGSize(width: size.width, height: size.height), isList: true)
                            .cornerRadius(10)
                            .matchedGeometryEffect(id: cat.id, in: animation)
                        
                        
                        Text("\(cat.name ?? "")")
                            .foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.trailing, 15)
                            //.offset(y: viewModel.offsetAnimation ? 0 : 100)
                            //.opacity(viewModel.offsetAnimation ? 1 : 0)
                        
                    }
                }
                .frame(height: 220)
                .zIndex(1)
                
                VStack(spacing: 0) {
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            InfoView(title: "name", subTitle: "\(cat.name ?? "")")
                            InfoView(title: "Description", subTitle: "\(cat.description ?? "")")
                            InfoView(title: "Origin", subTitle: "\(cat.origin ?? "")")
                            InfoView(title: "Wikipedia URL", subTitle: "\(cat.wikipedia_url ?? "")")
                            InfoView(title: "Life Span", subTitle: "\(cat.life_span ?? "")")
                            InfoView(title: "dog Friendly", subTitle: "\(cat.dog_friendly ?? 0)")
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, 15)
          
                    
                }
                .padding(.top, 20)
                .padding(.horizontal, 15)
                .padding(.leading, 30)
                //.offset(y: viewModel.offsetAnimation ? 0 : 100)
                //.opacity(viewModel.offsetAnimation ? 1 : 0)
                
                
                
                
            }
   
            
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background{
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                //.opacity(viewModel.animateContent ? 1 : 0)
            
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
