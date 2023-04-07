//
//  CatDetailView.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import SwiftUI

struct CatDetailView: View {
    @EnvironmentObject var viewModel : CatsListViewModel
    var cat : Cats
    
    init (cat : Cats) {
        self.cat = cat
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack (alignment: .leading) {
          
                
                Text(cat.description!)
                    .font(.system(size: 18, design: .default))
                    .padding(.bottom, 10)
                
                /*
                 Text("**Origin :** \(cat.origin)")
                     .font(.system(size: 18, design: .default))
                     .padding(.bottom, 10)
                 
                 Text("**Wikipedia Url :** \(cat.wikipedia_url)")
                     .font(.system(size: 18, design: .default))
                     .padding(.bottom, 10)
                 
                 Text("**Life Span :** \(cat.life_span)")
                     .font(.system(size: 18, design: .default))
                     .padding(.bottom, 10)
                 
                 Text("**Dog Friendly :** \(cat.dog_friendly)")
                     .font(.system(size: 18, design: .default))
                     .padding(.bottom, 10)
                 */
            }.padding()
                .navigationTitle(cat.name!)
                .toolbar {
                    Image(self.viewModel.getFavori(cat: cat) ? "heart-1" : "heart")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
        }
    }
}

struct CatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
