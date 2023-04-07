//
//  CatCardView.swift
//  TheCat
//
//  Created by İbrahim Güler on 7.04.2023.
//

import SwiftUI

struct CatCardView: View {
    @EnvironmentObject var viewModel : CatsListViewModel
    
    var cat : Cats
    var animation: Namespace.ID
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let rect = $0.frame(in: .named("SCROLLVIEW"))
            HStack(spacing: -25) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(cat.name)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Cat Origin is \(cat.origin)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 4) {
                        Text("Read more")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        
                        Text("Views")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.08), radius: 8,x: 5,y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8,x: -5,y: -5)
                }
                .zIndex(1)
                .offset(x:viewModel.animateCurrentCat && viewModel.selectedCat?.id == cat.id ? -20 : 0)
                
                ZStack {
                    
                    if !(viewModel.showDetailView && viewModel.selectedCat?.id == cat.id) {
                        Image(uiImage: "data")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width / 2, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .matchedGeometryEffect(id: cat.id, in: animation)
                            .shadow(color: .black.opacity(0.1), radius: 5,x: 5,y: 5)
                            .shadow(color: .black.opacity(0.1), radius: 5,x: -5,y: -5)
        
                            
                        
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: size.width)
            .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 1, y: 0, z: 0), anchor: .bottom,anchorZ: 1, perspective: 0.5)
        }
        .frame(height: 220)
    }
        // Used to set the rotation effect.
        func convertOffsetToRotation(_ rect: CGRect) -> CGFloat {
            let cardHeight = rect.height
            let minY = rect.minY - 20
            let progress = minY < 0 ? (minY / cardHeight) : 0
            let constrainedProgress = min(-progress, 1.0)
            return constrainedProgress * 90
        }
}

struct CatCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
