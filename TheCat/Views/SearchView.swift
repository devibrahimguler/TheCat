//
//  SearchView.swift
//  TheCat
//
//  Created by İbrahim Güler on 8.04.2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel : CatsViewModel
    @FocusState var startTF: Bool
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 15) {
                Button {
                    withAnimation{
                        startTF = false
                        viewModel.searchActivated = false
                        viewModel.searchText = ""
                        viewModel.searchCats = []
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                }
                
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                    
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("", text: $viewModel.searchText)
                        .placeholder(when: viewModel.searchText.isEmpty) {
                                Text("search").foregroundColor(.gray)
                        }
                        .foregroundColor(.black)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background {
                    Capsule()
                        .strokeBorder(Color.black,lineWidth: 1.5)
                }
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
                
            }
            .padding(.horizontal)
            .padding(.top)
            
            if let cats = viewModel.searchCats {
                if cats.isEmpty {
                    VStack{
                        Text("Item not found !")
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
                if !viewModel.searchText.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Color.white
                .ignoresSafeArea()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Used to make a view within a view.
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

