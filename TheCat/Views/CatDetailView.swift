//
//  CatDetailView.swift
//  TheCat
//
//  Created by İbrahim Güler on 12.04.2022.
//

import SwiftUI

struct CatDetailView: View {
    var cat : CatsViewModel
    var catsListViewModel : CatsListViewModel
    
    init (cat : CatsViewModel, catsListViewModel : CatsListViewModel) {
        self.cat = cat
        self.catsListViewModel = catsListViewModel
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack (alignment: .leading) {
                Images(url: cat.image)
                    .frame(height: UIScreen.main.bounds.height * 0.25)
                    .padding(.bottom, 10)
                
                Text(cat.description)
                    .font(.system(size: 18, design: .default))
                    .padding(.bottom, 10)
                
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
            }.padding()
                .navigationTitle(cat.name)
                .toolbar {
                    Image(self.catsListViewModel.getFavori(cat: cat) ? "heart-1" : "heart")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
        }
    }
}

struct CatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Test_CatDetailView()
    }
    
    struct Test_CatDetailView : View {
        var cat : CatsViewModel = CatsViewModel(cats: Cats(id: "abys", image: CatsImages(id: "0XYvRd7oD", url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"), name: "Abyssinian", description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.", origin: "Egypt", wikipedia_url: "https://en.wikipedia.org/wiki/Abyssinian_(cat)", life_span: "14 - 15", dog_friendly: 4, reference_image_id: "0XYvRd7oD"))
        
        
        
        var body: some View {
            CatDetailView(cat: cat, catsListViewModel: CatsListViewModel())
        }
    }
}
